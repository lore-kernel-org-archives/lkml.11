Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF2FEC48BE4
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Aug 2022 12:00:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239914AbiHYMAC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Aug 2022 08:00:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241357AbiHYL7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 07:59:51 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DDCB6478
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 04:59:48 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id sd33so17707427ejc.8
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 04:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=xm2IuzH5NkZjS+pGQICoXtNYf1UT8FOIbW5GvULWcoA=;
        b=iu+0gpGpBjyb9eLSkk/hvanJB13scD0nbhXExD680dGqza8HhVPgAJ5dkatND3Ymqk
         SgdNdX2oUTB2SrFjRUWQeS/j9TTOxuvpYFQ6PWrfjAfHwKIigl36OUNnvMukDYOe+6VT
         dE63DGgnxZ+kAOa5Zt3UFs0uN4+ItKKtFqvmxPvxQOv6iFa6jEraOjmc81Tl6oJ/rD0J
         btHWZAAXpjEYUm+nZeWQ6hXoimIt/Rnli9pM8h4rsKiOJwSamCh0p/CcHsC0mijAfCn5
         E7kyXufUJdwKhg77NMbCdtwqAxHw6C0ZAbfQEC/07m11gj++xNHaTWxOMjOR+p6CsKti
         Vulg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=xm2IuzH5NkZjS+pGQICoXtNYf1UT8FOIbW5GvULWcoA=;
        b=gZK4TLbTXbdg65w4AINUmeVi2g8+YL2V36+6zp8doG81QynZF6iNHPnsxjY5LIk3ra
         +Hmsq5yqvWgLjP2O+kLo81PvAHWd/8uj6OT3UJ3ou0D7XK9hHeH1MCzGIJXL/Qh5nMmg
         SQGgsDatA3KPEh4ptsfM6lCtciTVT+vUkRBSH+31zLvsayzlLn6STe6RhCi58sk8i40n
         4T4+uTCfnrzBIiT/vwXkWGBvT6e6+XXR7biurboUl0lN+BpeFFiJSt1/rIKVwIJbKG9O
         VN61eSQ+QHQd+8Mn2CVX+4uZEaeOKN5GfzJHylLIbnZAeul2ZEXkig5KmlpFOrkHQInD
         9HFw==
X-Gm-Message-State: ACgBeo3oTCc37IDKuNeX6eDMNMxn1h7XmLtmwHuyHx6XWk9A1zaptHYh
        9B+KLD6F1r1kGXxytERNZfiOACNmDKSOAaYIDr0YZg==
X-Google-Smtp-Source: AA6agR7mZ5xAEcHD76JxST+kccxcpJ3PWAeaLz5jXJFne317cGpVf3riJ/pYd4HZ5ibAHmPfHoKVmG+KaiO0PSVkxSo=
X-Received: by 2002:a17:906:9b86:b0:73d:72cf:72af with SMTP id
 dd6-20020a1709069b8600b0073d72cf72afmr2330972ejc.440.1661428787087; Thu, 25
 Aug 2022 04:59:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220621112904.65674-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20220621112904.65674-1-andriy.shevchenko@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 25 Aug 2022 13:59:35 +0200
Message-ID: <CACRpkdYCduUyR-H1ztQ4iQ+Z+nMhFe6V2+Re1zQVM1Mk0hG+_w@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] pinctrl: nomadik: Convert drivers to use struct
 pingroup and PINCTRL_PINGROUP()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 21, 2022 at 1:29 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> The pin control header provides struct pingroup and PINCTRL_PINGROUP() macro.
> Utilize them instead of open coded variants in the driver.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Patch applied, was meaning to test it on target but was too ambitious
about that and forgot it. If there is a problem I will notice anyway!

Yours,
Linus Walleij
