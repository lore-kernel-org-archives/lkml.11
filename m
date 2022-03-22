Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EE5AC433FE
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Mar 2022 12:19:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234802AbiCVMVG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Mar 2022 08:21:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234794AbiCVMVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 08:21:04 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61C2927CE3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 05:19:36 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id q20so10703728wmq.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 05:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ykocWOAz0Uq+UDyAgiBZ8KQwD5sPDMIaIusCx46+2Ks=;
        b=kKY+qozz/qcYG+/WjZpLBwTWsZ5tYB8zXlI70JV8xHO0EZdrLRb7kZRqQpLv1AKLeE
         V+ah86LXYoSNB33ep5SGvLR9hA81Yxkx4CMt8bv6tX4ZZaLpnDpmKrWXjhG9uQiAalg6
         S80CRpCoCzGXB/IyUuz30WFr39JPiBlgTtiJo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ykocWOAz0Uq+UDyAgiBZ8KQwD5sPDMIaIusCx46+2Ks=;
        b=tbvjnYQ3m4hh+T3+rn8oQ86I3Ge2S0YF5EJ9JDNVtcQtvFdDKj1ymObY0Y9daCsVq0
         Lq0FtxUUYlplISGwhuYwoZatS/lk1vHb3L9459ZB9y+FeXwJD7d3pfh1Zu4gfCGW96r5
         G+ga22CZhdqftjqh5RWHXFL9e3dAX5Ozrclrbw/ZGe4K7RWoCSkCkLTl2VEjEeTAm2SQ
         BkBmko11jxUdQt/GwXvt1iXf/yrXsxxeDej/oV4jQ5n7dZLdy6uGAoO8XTsxZJDT4S59
         8oHaI3qScB9zZdGHd0d341w4fIUKwuvofbGtUnFko2UTk3YAdh/wd8j0dAibjttkpfs4
         EyHQ==
X-Gm-Message-State: AOAM532czKOzDS1hwNqB7c5L/DFUD/OBESY9jYGRpEkIzhxORWEQSyjz
        BWgRTM6RTZZ/hdRLj9psuyJooQ==
X-Google-Smtp-Source: ABdhPJyFLwDH5nAIAcJ9p0nfgQAFOIKhSm1IVpSDXY9TL57Dd6kWriAXvFvzHaFUdFaXQn45mmhONA==
X-Received: by 2002:a1c:e908:0:b0:38c:782c:2a62 with SMTP id q8-20020a1ce908000000b0038c782c2a62mr3433024wmc.135.1647951574957;
        Tue, 22 Mar 2022 05:19:34 -0700 (PDT)
Received: from google.com ([37.228.205.1])
        by smtp.gmail.com with ESMTPSA id l13-20020adfbd8d000000b002040daf5dffsm9233464wrh.18.2022.03.22.05.19.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 05:19:34 -0700 (PDT)
Date:   Tue, 22 Mar 2022 12:19:32 +0000
From:   Fabio Baltieri <fabiobaltieri@chromium.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        chrome-platform@lists.linux.dev, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] dt-bindings: update google,cros-ec-pwm documentation
Message-ID: <Yjm+1ON8o5y/qcKG@google.com>
References: <20220321143222.2523373-1-fabiobaltieri@chromium.org>
 <20220321143222.2523373-4-fabiobaltieri@chromium.org>
 <09b4b714-4fb5-f2af-5a88-b48cbff35b7d@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09b4b714-4fb5-f2af-5a88-b48cbff35b7d@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 21, 2022 at 04:47:54PM +0100, Krzysztof Kozlowski wrote:
> On 21/03/2022 15:32, Fabio Baltieri wrote:
> > Update google,cros-ec-pwm node documentation to mention the
> > google,use_pwm_type property.
> > 
> > Signed-off-by: Fabio Baltieri <fabiobaltieri@chromium.org>
> > ---
> >  .../devicetree/bindings/pwm/google,cros-ec-pwm.yaml         | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.yaml b/Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.yaml
> > index 4cfbffd8414a..2224e8e07029 100644
> > --- a/Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.yaml
> > +++ b/Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.yaml
> > @@ -19,6 +19,12 @@ description: |
> >  properties:
> >    compatible:
> >      const: google,cros-ec-pwm
> > +
> > +  google,use_pwm_type:
> 
> Hyphens, not underscores.

Oh thanks, will change for v2.

> 
> 
> Best regards,
> Krzysztof

-- 
Fabio Baltieri
