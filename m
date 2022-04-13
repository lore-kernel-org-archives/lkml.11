Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77F60C433FE
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Apr 2022 17:19:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237259AbiDMRVq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Apr 2022 13:21:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237175AbiDMRVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 13:21:42 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E274D6E
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 10:19:21 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id mp16-20020a17090b191000b001cb5efbcab6so6864917pjb.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 10:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lME6SHAgnKlmWBOKOizWm8XVxJpddGvUH85Ld8tYptw=;
        b=UTabBOIrMAwX7G926h1g/XxwxCNw+redFrANl5vrbvEVFXqf3dVOsfKbJlN/8qVd6b
         9gZ/mx8JQZDJ2nW52LktmlO9klbmAm34eSmWShJ+HKBGgunwO3ZUW6fiHXwTKvXPPJwK
         EjYmODPltiC3D/nlbGntEawXo1fKfBXxUO7ug=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lME6SHAgnKlmWBOKOizWm8XVxJpddGvUH85Ld8tYptw=;
        b=4fVYCUTC4HhhIc0zx0OLVW9zoaC4UKKw7w36j2stI+5KNy152Zb1W98wJWkQ5ym51D
         lyj/EY29typKCHyncd12ztFMWZPDcYvUUBHbkw+d0JLNOSNOKRiAaI69/ku5C4EcEEEO
         D+vJg5NSfUCyEUJv1sEz9MT+quPIdS6Ryi/Hioa8QGOO7HIaAm6raZIzbF54JwJZvCp7
         ofoAQdXT0LJst+a0D9DvYqi9xU2zQ/5hJpv6K0lBM8+3RMvUX5dW2e/p7ajdaZZ6a+Uy
         c16LcSe8pLywmwtBkVeeqFWXRqlP21aLohzZfGZcVhKM7MoxJX9IWVfk1OuR5DfobbYw
         yq2Q==
X-Gm-Message-State: AOAM530LpivzBTUl8UT+82ltXmL7dsa1gZv7rmSpWFGsae9kJH33t2GT
        OWS8XO4WYaz65jcZfNHiEz4L5A==
X-Google-Smtp-Source: ABdhPJz7ppfzbQ8wE0OtGonV82yO6sDyoE48BgV4umaaIEAVFFGDk/8CJYoUUK24mmhN04OGb0xKpg==
X-Received: by 2002:a17:902:e74d:b0:156:9d3c:4271 with SMTP id p13-20020a170902e74d00b001569d3c4271mr43099858plf.79.1649870360761;
        Wed, 13 Apr 2022 10:19:20 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:6a4f:9277:743f:c648])
        by smtp.gmail.com with UTF8SMTPSA id b25-20020a637159000000b00381fda49d15sm6821133pgn.39.2022.04.13.10.19.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Apr 2022 10:19:20 -0700 (PDT)
Date:   Wed, 13 Apr 2022 10:19:18 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_rohkumar@quicinc.com,
        srinivas.kandagatla@linaro.org, dianders@chromium.org,
        swboyd@chromium.org, judyhsiao@chromium.org,
        Venkata Prasad Potturu <quic_potturu@quicinc.com>
Subject: Re: [PATCH v9 1/2] arm64: dts: qcom: sc7280: Add pinmux for I2S
 speaker and Headset
Message-ID: <YlcGFlFXhh+bHGko@google.com>
References: <1649861047-7811-1-git-send-email-quic_srivasam@quicinc.com>
 <1649861047-7811-2-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1649861047-7811-2-git-send-email-quic_srivasam@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2022 at 08:14:06PM +0530, Srinivasa Rao Mandadapu wrote:
> Add pinmux nodes for primary and secondary I2S for SC7280 based platforms.
> 
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
> Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
