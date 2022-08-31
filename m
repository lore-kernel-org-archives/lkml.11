Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 786B9ECAAD3
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Aug 2022 18:01:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231226AbiHaSBL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Aug 2022 14:01:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiHaSBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 14:01:09 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78202D4BE7
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 11:01:07 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-11f0fa892aeso17666355fac.7
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 11:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=T6Du1Lo5xImAO249U1dETl4IIbiFdjm8Fx7yNl0ICjY=;
        b=MbYKgq9YQ6Cmkjnxo/SEbnM4RZKXJbf89tkfIphzPRlEB3rBPLNslG/zc7Fa5N37Fc
         lhVNZA4SRNJ06uCP16o+JMRPLBbB7LZLhUmAhdDCGlpymbSMzCwQst5srlXLX+H8VtkA
         XUAFrNIQJJI0kOzoWw7DNXGkMWcZoWg9//pcSu8QypDj4UjYgibbK79Z1QjY7pjyvltg
         qxcihlzG1LpIR9Gb3RuZ69YrMRSOUl1bmFd7L9fhg8jqKoigPuvkaAZ1hWbqemGqF+VR
         hXqzIImXiW+0FabsOWFDktXerKkrjF17lUaPV1+xNvHCDpkytsZXVVlzzaRlQ8JfF3zN
         k+aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=T6Du1Lo5xImAO249U1dETl4IIbiFdjm8Fx7yNl0ICjY=;
        b=YMuxNFIcY6wXxsQOVHmGfe5K5A+VVit3OEptaQa73/7co475s6JibanF6r4Ao3yu3M
         OYaY4lQJGcE7LPq2OzDzEysGErJXy7m7IPdm/tqs++3rIvJ3iOio1AByI3ZWIRw1V8zc
         Q6Dfu/Wo+sIauNjMIA6EuydMG46bwEoY1/6AA4bYAKycTogaOfi5QkuUg+mP9iZ1124/
         PZhww+vwrCOGXZEm0g91JeAx5lw1jwr2UCUF9lDPinF2tTvSIsudfNRNvxS5iB/ufdDu
         45IFBMFxD1DeObYBwi3/3Qyuz5y9uEgShUwMyHibJEHhTtCAa2SOqtxjGZ5yxJPslIqu
         ddlg==
X-Gm-Message-State: ACgBeo1PwLENMV//0XGnYVKnKjkVg7lVEx79LjsmellHtL1oJ6UTQsNW
        MQPd8PiY8XwNgVacbd3KBB1OJXZZ050FyKJ1exeMhCUmqC6C2A==
X-Google-Smtp-Source: AA6agR4nuWTt+l/HHXALlIvuHu0a36M8RihXtAB0CgHufnQWYfzsfDJoK3Av9fP0SMKZV1RXp2U8YrypIgn6ZCwEbcY=
X-Received: by 2002:a05:6808:1641:b0:345:4f32:b30a with SMTP id
 az1-20020a056808164100b003454f32b30amr1800917oib.189.1661968866436; Wed, 31
 Aug 2022 11:01:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220823095915.v7.1.I55189adfdb8d025fc991a0fa820ec09078619b15@changeid>
In-Reply-To: <20220823095915.v7.1.I55189adfdb8d025fc991a0fa820ec09078619b15@changeid>
From:   Tim Van Patten <timvp@google.com>
Date:   Wed, 31 Aug 2022 12:00:55 -0600
Message-ID: <CANkg5ezTvzSFLkRWbhMDUqezQXW6996DYVohWMUa+cYwSB+YBw@mail.gmail.com>
Subject: Re: [PATCH v7] platform/chrome: cros_ec_lpc: Move host command to prepare/complete
To:     rrangel@chromium.org, robbarnes@google.com
Cc:     Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
        Tzung-Bi Shih <tzungbi@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Friendly ping on this patch.


On Tue, Aug 23, 2022 at 9:59 AM Tim Van Patten <timvp@google.com> wrote:
>
> Update cros_ec_lpc_pm_ops to call cros_ec_lpc_prepare() during PM
> .prepare() and cros_ec_lpc_complete() during .complete(). This moves the
> host command that the AP sends and allows the EC to log entry/exit of
> AP's suspend/resume more accurately.
>
> Signed-off-by: Tim Van Patten <timvp@google.com>
> ---
>
> Changes in v7:
> - Rename "host event" to "host command" in title/description.
>
> Changes in v6:
> - Fully restore fixes from v3.
>
> Changes in v5:
> - Restore fixes from v3.
>
> Changes in v4:
> - Update title and description.
>
> Changes in v3:
> - Update cros_ec_lpc_suspend() to cros_ec_lpc_prepare()
> - Update cros_ec_lpc_resume() to cros_ec_lpc_complete()
>
> Changes in v2:
> - Include cros_ec_resume() return value in dev_info() output.
> - Guard setting .prepare/.complete with #ifdef CONFIG_PM_SLEEP.
>
>  drivers/platform/chrome/cros_ec_lpc.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/platform/chrome/cros_ec_lpc.c b/drivers/platform/chrome/cros_ec_lpc.c
> index 7677ab3c0ead..4158bdeee197 100644
> --- a/drivers/platform/chrome/cros_ec_lpc.c
> +++ b/drivers/platform/chrome/cros_ec_lpc.c
> @@ -530,23 +530,31 @@ static const struct dmi_system_id cros_ec_lpc_dmi_table[] __initconst = {
>  MODULE_DEVICE_TABLE(dmi, cros_ec_lpc_dmi_table);
>
>  #ifdef CONFIG_PM_SLEEP
> -static int cros_ec_lpc_suspend(struct device *dev)
> +static int cros_ec_lpc_prepare(struct device *dev)
>  {
>         struct cros_ec_device *ec_dev = dev_get_drvdata(dev);
>
> +       dev_info(dev, "Prepare EC suspend\n");
> +
>         return cros_ec_suspend(ec_dev);
>  }
>
> -static int cros_ec_lpc_resume(struct device *dev)
> +static void cros_ec_lpc_complete(struct device *dev)
>  {
>         struct cros_ec_device *ec_dev = dev_get_drvdata(dev);
> +       int ret;
> +
> +       ret = cros_ec_resume(ec_dev);
>
> -       return cros_ec_resume(ec_dev);
> +       dev_info(dev, "EC resume completed: ret = %d\n", ret);
>  }
>  #endif
>
>  static const struct dev_pm_ops cros_ec_lpc_pm_ops = {
> -       SET_LATE_SYSTEM_SLEEP_PM_OPS(cros_ec_lpc_suspend, cros_ec_lpc_resume)
> +#ifdef CONFIG_PM_SLEEP
> +       .prepare = cros_ec_lpc_prepare,
> +       .complete = cros_ec_lpc_complete
> +#endif
>  };
>
>  static struct platform_driver cros_ec_lpc_driver = {
> --
> 2.37.2.609.g9ff673ca1a-goog
>


-- 

Tim Van Patten | ChromeOS | timvp@google.com | (720) 432-0997
