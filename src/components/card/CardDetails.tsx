import { h, Component } from 'preact';
import type { JSX } from 'preact';
import Spinner from '../Spinner';
import Button from '../Button';

interface CardDetailsProps {
  ref: (ref: any) => void;
  initialState?: 'loading' | 'submitted';
  initialBrand?: string;
  initialLastFour?: string;
  onClickEdit: () => void;
  labels?: {
    addCard?: string;
    submittedCardTitle?: string;
    changePaymentMethod?: string;
  };
  brandImages?: Record<string, string | undefined>;
}

interface CardDetailsState {
  state: 'loading' | 'submitted';
  brand: string;
  lastFour: string;
  showForceEditButton: boolean;
}

class CardDetails extends Component<CardDetailsProps, CardDetailsState> {
  private forceEditTimeout?: number = undefined;

  constructor(props: CardDetailsProps) {
    super(props);

    console.log('NativeCard: constructor with props:', props);

    this.state = {
      state: props.initialState ?? 'loading',
      brand: props.initialBrand ?? '',
      lastFour: props.initialLastFour ?? '',
      showForceEditButton: false,
    };
  }

  componentDidMount(): void {
    console.log('NativeCard mounted with initial state:', this.state);
    if (this.state.state === 'loading') {
      this.startForceEditTimeout();
    }
  }

  componentWillUnmount(): void {
    if (this.forceEditTimeout) {
      clearTimeout(this.forceEditTimeout);
    }
  }

  private startForceEditTimeout = (): void => {
    if (this.forceEditTimeout) {
      clearTimeout(this.forceEditTimeout);
    }

    this.forceEditTimeout = window.setTimeout(() => {
      if (this.state.state === 'loading') {
        this.setState({ showForceEditButton: true });
      }
    }, 5000);
  };

  /**
   * Public API to update card state - triggers re-render
   */
  public updateCardState = (updates: Partial<CardDetailsState>): void => {
    console.log('NativeCard: Updating state with:', updates);

    this.setState((prevState) => {
      const newState = { ...prevState, ...updates };

      // Reset force edit button when changing to loading
      if (updates.state === 'loading') {
        newState.showForceEditButton = false;
        // Start timeout for new loading state
        setTimeout(() => this.startForceEditTimeout(), 0);
      }

      return newState;
    });
  };

  /**
   * Public API to get current state
   */
  public getCardState = (): CardDetailsState => {
    return this.state;
  };

  render(): JSX.Element {
    const { onClickEdit, labels, brandImages = {} } = this.props;
    const { state, lastFour, brand, showForceEditButton } = this.state;

    const labelConfig = {
      addCard: labels?.addCard ?? 'Add card',
      submittedCardTitle: labels?.submittedCardTitle ?? 'Selected card:',
      changePaymentMethod: labels?.changePaymentMethod ?? 'Change',
    };

    console.log('NativeCard render with state:', this.state, brandImages);
    const brandImage = brandImages[brand] ?? brandImages['card'];

    const handleImageError = (e: Event): void => {
      const target = e.currentTarget as HTMLImageElement;
      target.src = this.props.brandImages?.card || '';
      if (!target.src) {
        target.style.display = 'none';
      }
    };

    if (state === 'loading') {
      return h(
        'div',
        {
          className: 'card-component card-component--loading',
          'data-testid': 'native-card-loading',
        },
        h(
          'div',
          { className: 'card-component__content' },
          Spinner({}),
          showForceEditButton &&
            h(Button, {
              variant: 'action',
              onClick: onClickEdit,
              ariaLabel: labelConfig.addCard,
              children: labelConfig.addCard,
            }),
        ),
      );
    }

    return h(
      'div',
      {
        className: 'card-component card-component--submitted',
        'data-testid': 'native-card-submitted',
      },
      h(
        'div',
        { className: 'card-component__content' },
        h(
          'div',
          { className: 'card-details' },
          h('h4', { className: 'card-details__title' }, labelConfig.submittedCardTitle),
          h(
            'div',
            { className: 'card-details__content' },
            brandImage &&
              h('img', {
                className: 'card-details__image',
                src: brandImage,
                alt: brand,
                width: 40,
                loading: 'lazy',
                onError: handleImageError,
              }),
            h('span', { className: 'card-details__number' }, `•••• •••• •••• ${lastFour || '••••'}`),
          ),
        ),
        h(Button, {
          classNameModifiers: ['edit'],
          variant: 'link',
          onClick: onClickEdit,
          inline: true,
          children: labelConfig.changePaymentMethod,
        }),
      ),
    );
  }
}

export default CardDetails;
