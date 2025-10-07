package com.foodello.adyen

import android.content.res.ColorStateList
import android.graphics.drawable.GradientDrawable
import android.view.ViewGroup
import android.widget.ImageButton
import android.widget.TextView
import androidx.core.content.ContextCompat
import com.foodello.adyen.style.asColorOrNull
import com.foodello.adyen.style.optJSObject
import com.foodello.adyen.style.optNonBlankString
import com.getcapacitor.JSObject

object SheetChromeApplier {
    data class Targets(
            val sheet: ViewGroup,
            val header: ViewGroup?,
            val headerTitle: TextView?,
            val headerClose: ImageButton?
    )

    fun apply(style: JSObject?, viewOptions: JSObject?, targets: Targets) {
        // Sheet surface
        val backgroundColor = style?.optNonBlankString("backgroundColor")?.asColorOrNull()
            ?: ContextCompat.getColor(targets.sheet.context, com.adyen.checkout.ui.core.R.color.white)

        // Apply corner radius with proper background color
        val cornerRadius = viewOptions?.optInt("cornerRadius", 24) ?: 24
        targets.sheet.setCornerRadius(cornerRadius.toFloat(), backgroundColor)

        // Remove any margins that might be causing spacing issues
        (targets.sheet.layoutParams as? ViewGroup.MarginLayoutParams)?.apply {
            setMargins(0, 0, 0, 0)
        }

        // Ensure the sheet fills the entire bottom sheet container
        targets.sheet.layoutParams = targets.sheet.layoutParams?.apply {
            width = ViewGroup.LayoutParams.MATCH_PARENT
            height = ViewGroup.LayoutParams.MATCH_PARENT
        }

        val titleText = viewOptions?.optNonBlankString("title")

        val titleColor =
            viewOptions?.optNonBlankString("titleColor")?.asColorOrNull()
                ?: style?.optJSObject("header")?.optNonBlankString("color")?.asColorOrNull()

        val titleBg =
            viewOptions?.optNonBlankString("titleBackgroundColor")?.asColorOrNull()
                ?: backgroundColor // Use sheet background to maintain continuity

        // Close button icon color
        val closeIconColor =
            viewOptions?.optNonBlankString("closeIconColor")?.asColorOrNull()
                ?: titleColor
                ?: style?.optNonBlankString("tintColor")?.asColorOrNull()

        targets.headerTitle?.let { tv ->
            if (!titleText.isNullOrEmpty()) tv.text = titleText
            titleColor?.let(tv::setTextColor)
            // Apply transparent background to let sheet corners show through
            tv.setBackgroundColor(ContextCompat.getColor(tv.context, android.R.color.transparent))
        }

        targets.header?.let { headerView ->
            // CRITICAL: Apply corner radius to header as well to match sheet
            headerView.setCornerRadius(cornerRadius.toFloat(), titleBg ?: backgroundColor)
            (headerView.layoutParams as? ViewGroup.MarginLayoutParams)?.setMargins(0, 0, 0, 0)

            // Ensure header doesn't have its own background that blocks corners
            headerView.clipToPadding = false
            headerView.clipChildren = false
        }

        targets.headerClose?.let { closeButton ->
            closeIconColor?.let { color ->
                closeButton.imageTintList = ColorStateList.valueOf(color)
            }

            viewOptions?.optNonBlankString("closeButtonBackgroundColor")?.asColorOrNull()?.let {
                closeButton.setBackgroundColor(it)
            }
        }
    }

    /** Apply corner radius to top corners only (bottom sheet style) */
    fun ViewGroup.setCornerRadius(radius: Float) {
        val drawable =
                GradientDrawable().apply {
                    cornerRadii =
                            floatArrayOf(
                                    radius,
                                    radius, // top-left
                                    radius,
                                    radius, // top-right
                                    0f,
                                    0f, // bottom-right
                                    0f,
                                    0f // bottom-left
                            )
                    setColor(ContextCompat.getColor(context, android.R.color.transparent))
                }
        background = drawable
    }

    /** Apply corner radius to all corners */
    fun ViewGroup.setCornerRadiusAll(radius: Float) {
        val drawable =
                GradientDrawable().apply {
                    cornerRadius = radius
                    setColor(ContextCompat.getColor(context, android.R.color.transparent))
                }
        background = drawable
    }

    /** Apply corner radius with background color */
    fun ViewGroup.setCornerRadius(radius: Float, backgroundColor: Int) {
        val drawable =
                GradientDrawable().apply {
                    cornerRadii =
                            floatArrayOf(
                                    radius,
                                    radius, // top-left
                                    radius,
                                    radius, // top-right
                                    0f,
                                    0f, // bottom-right
                                    0f,
                                    0f // bottom-left
                            )
                    setColor(backgroundColor)
                }
        background = drawable
    }
}
