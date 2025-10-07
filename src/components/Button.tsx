import type { ComponentChildren, h, Ref } from 'preact';

type ButtonProps = {
  children: ComponentChildren;
  status?: string;
  /**
   * Class name modifiers will be used as: `adyen-checkout__button--${modifier}`
   */
  classNameModifiers?: string[];
  variant?: 'primary' | 'secondary' | 'ghost' | 'action' | 'link' | 'iconOnly';
  disabled?: boolean;
  label?: string | h.JSX.Element;
  onClickCompletedLabel?: string | h.JSX.Element;
  ariaLabel?: string;
  ariaDescribedBy?: string;
  secondaryLabel?: string;
  icon?: string;
  onClickCompletedIcon?: string;
  inline?: boolean;
  href?: string;
  target?: string;
  rel?: string;
  onClick?: (e: h.JSX.TargetedMouseEvent<HTMLButtonElement>, callbacks?: { complete?: () => void }) => void;
  onKeyDown?: (event: KeyboardEvent) => void;
  onKeyPress?: (event: KeyboardEvent) => void;
  buttonRef?: Ref<HTMLButtonElement>;
  onMouseEnter?: (event: MouseEvent) => void;
  onMouseLeave?: (event: MouseEvent) => void;
  onFocus?: (event: FocusEvent) => void;
  onBlur?: (event: FocusEvent) => void;
};

function Button(props: ButtonProps) {
  const {
    children,
    variant,
    classNameModifiers,
    status,
    label,
    onClickCompletedLabel,
    ariaLabel,
    ariaDescribedBy,
    secondaryLabel,
    icon,
    onClickCompletedIcon,
    inline,
    href,
    target,
    rel,
    buttonRef,
    ...restProps
  } = props;

  return (
    <button
      type="button"
      tabIndex={0}
      className={`adyen-checkout__button adyen-checkout__button--${variant} adyen-checkout__button--${classNameModifiers}`.trim()}
      aria-label={ariaLabel}
      aria-describedby={ariaDescribedBy}
      ref={buttonRef}
      {...restProps}
    >
      {children}
    </button>
  );
}

export default Button;
