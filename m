Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B27CBC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 May 2022 21:39:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbiEWVjq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 May 2022 17:39:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbiEWVjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 17:39:02 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BD2A5D5E7
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 14:39:00 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id n18so14224098plg.5
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 14:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gf8EhzMTzr6R8xHXhTvUK8RjrOMiGCSQG1OHTThnQ0Q=;
        b=bf5J13mJD4dQWnnlunn4dkiB+SvrNEkxLmN7hsitbi1+sQ55wql6aGhh7PEww6h+8A
         wtHA3RnQngev5DD/+DUjeEXPLDxn170USEcWZHn7mJnsaLrn5nNuOIqtvO1lgb0gAeph
         v7f4FQAT58Ig5COAqyJTjFvmE7ZktxicgKOHY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gf8EhzMTzr6R8xHXhTvUK8RjrOMiGCSQG1OHTThnQ0Q=;
        b=Ng02Y98mgT9brKCxWgYMOpLWXGJcFVUdKEAMORyPUeSxHwtyICCGCbedZGrCVCOdj8
         flOJ/Irp0nJSiqC/Dcim6Wl2+W/mF2hzW8mrFcdq54r4U5lpW8FPP5xC+nU38qTUgGGw
         SBWuPkIozghlk14Zg3wSUh8SnoAhl66GG6dmosYMZNi1pinqIgc5a93zcuEGIoPEYfdc
         Am/DqhSmq6BnPJYzBPukZT2vuC8UAtITwoliISBWojvs0ary2RzYjsjgcthuAb73OYnM
         8i33ZrcfFAzOZeihDH9J8JfO7k0H3F3PSLW9zmFGZeUd7kWwDaDpkgcANfH2hZIrzosd
         ZNaw==
X-Gm-Message-State: AOAM5321DyoHV6tbHvzEaeKR+gsDxz3n6itfAfx+2elXv4heUcJ65O/n
        A7mXOeyeSy0NLMGO/ZYovr15ZA==
X-Google-Smtp-Source: ABdhPJyypJ8MhqaHRuyTJETDOVjTN0+TC0VHaKHFVnlL4gugK6qSzB6i87qOGesoOy/hnm6MTNkYBA==
X-Received: by 2002:a17:902:ce8d:b0:161:761f:6999 with SMTP id f13-20020a170902ce8d00b00161761f6999mr24171527plg.125.1653341939959;
        Mon, 23 May 2022 14:38:59 -0700 (PDT)
Received: from localhost ([2620:15c:11a:202:d9e2:8472:9ac:8532])
        by smtp.gmail.com with UTF8SMTPSA id d66-20020a621d45000000b005182fd977e4sm7706768pfd.108.2022.05.23.14.38.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 May 2022 14:38:59 -0700 (PDT)
Date:   Mon, 23 May 2022 14:38:58 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        swboyd@chromium.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] HID: i2c-hid: elan: Add support for Elan eKTH6915
 i2c-hid touchscreens
Message-ID: <Yov+8u5Ohrzynlx9@google.com>
References: <20220523142257.v2.1.Iedc61f9ef220a89af6a031200a7850a27a440134@changeid>
 <20220523142257.v2.2.I2d3f735a485157eeaa24d60be8a327f98101789d@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220523142257.v2.2.I2d3f735a485157eeaa24d60be8a327f98101789d@changeid>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 23, 2022 at 02:23:24PM -0700, Douglas Anderson wrote:
> Like many i2c-hid touchscreen controllers, the Elan eKTH6915 has a
> reset GPIO hooked up to it. According to the datasheet, the way we're
> supposed to turn the touchscreen on is:
> 
> 1. Turn on the 3.3V supply.
> 2. Turn on the IO supply. It's OK if this is hardwired to the 3.3V
>    supply, but if it's not then it must be turned on _after_ the 3.3V
>    supply.
> 3. Wait >= 1 ms.
> 4. Deassert the reset GPIO (reset GPIO is active low, so there would
>    be a leakage path if this was deasserted _before_ the IO supply).
> 5. Wait 300 ms.
> 
> Much of the above can be handled by the generic i2c-hid-of driver, but
> the "reset" GPIO is not supported by that driver. Thus we'll do the
> same as we did for Goodix and add a new tiny driver that uses the
> i2c-hid core.
> 
> NOTE: support for this new touchscreen could theorically fit into the
> Goodix driver. I've made it a separate driver because the Elan driver
> supports _two_ regulators and it's unclear exactly how that would fit
> in with commit 18eeef46d359 ("HID: i2c-hid: goodix: Tie the reset line
> to true state of the regulator").
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
