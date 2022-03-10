Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A513C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Mar 2022 22:35:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344368AbiCJWgD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Mar 2022 17:36:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245380AbiCJWgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 17:36:00 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAADEBDE55
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 14:34:58 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id t2so3640549pfj.10
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 14:34:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dm3qB2w2lQ7IFy1ipeKnHCOmhqitdfZXH/ycCypXYJA=;
        b=XbtHN78KIecFW+02Yyb63lZj4KZ2A9h4133DWVgegrpcThbSKDbzoYlFJPUlH5aMKW
         AjdapHStDHVE0xYa01ndPaYUTm8iT6/QuKTi2DPbu5LWDW8PSuM67v9LSoIYV99kPOyv
         t2m27yiE+DisfL7G6lcgeyzawilqE1zNRz0bI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dm3qB2w2lQ7IFy1ipeKnHCOmhqitdfZXH/ycCypXYJA=;
        b=d8kziF0gHx+d9tjewqD3w6wXDo/TKRXEc6PZBaCLQJ5BvDFM0juFdGw8ezlwUclFAp
         +b9w0Hg4MgJi0OwMpTfsArCvZi83EL99D1DocrOZJEToe/s5/stOP4v4Bfs0I6fpMeTn
         lTphJvCKSEIjonEo9NYyyWlQ7u0KEKDe/gAe2fQnui+bt+CMai+D9O6+Dnab0xI+HSHj
         ONJ5UJoW3p87aTsCXbJteTxxwUkA3aop3K+WsCT+6doWaVpEiLllXR+ufuz+uluLxbQU
         xAJR9xMmbVcbgsDnQWzuzuM3cR2KD18tffaEKsEprDYfsACB1WT7VO0N6PSH6HSHqzUT
         nxQg==
X-Gm-Message-State: AOAM533SgWcLXQ/vetI/AxQykNVMVSpPx78maDN1NJ/+X8cFCrC3BfSH
        LP1awfsdyms5YEXXFz3e1oI8vW7SF051CA==
X-Google-Smtp-Source: ABdhPJy1z6bn6NBQfuRdnkrdCb5mXCccJv1Spi5pKAOp4pz2vxeEh5T0s6tYVvmFaKZb0Eg8n9tp7g==
X-Received: by 2002:a63:ad47:0:b0:373:4c14:35e2 with SMTP id y7-20020a63ad47000000b003734c1435e2mr5813069pgo.67.1646951698203;
        Thu, 10 Mar 2022 14:34:58 -0800 (PST)
Received: from localhost ([2620:15c:202:201:60f0:9f89:56be:75e9])
        by smtp.gmail.com with UTF8SMTPSA id d11-20020a056a0010cb00b004e1b76b09c0sm7991122pfu.74.2022.03.10.14.34.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Mar 2022 14:34:57 -0800 (PST)
Date:   Thu, 10 Mar 2022 14:34:56 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sc7280-herobrine: Fix PCIe regulator
 glitch at bootup
Message-ID: <Yip9EE+gcyRcSydd@google.com>
References: <20220310130429.1.Id41fda1d7f5d9230bc45c1b85b06b0fb0ddd29af@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220310130429.1.Id41fda1d7f5d9230bc45c1b85b06b0fb0ddd29af@changeid>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 10, 2022 at 01:04:34PM -0800, Douglas Anderson wrote:
> While scoping signals, we found that the PCIe signals weren't
> compliant at bootup. Specifically, the bootloader was setting up PCIe
> and leaving it configured, then jumping to the kernel. The kernel was
> turning off the regulator while leaving the PCIe clock running, which
> was a violation.
> 
> In the regulator bindings (and the Linux kernel driver that uses
> them), there's currently no way to specify that a GPIO-controlled
> regulator should keep its state at bootup. You've got to pick either
> "on" or "off". Let's switch it so that the PCIe regulator defaults to
> "on" instead of "off". This should be a much safer way to go and
> avoids the timing violation. The regulator will still be turned off
> later if there are no users.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
