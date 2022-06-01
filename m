Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87FB1CCA473
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jun 2022 21:18:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231316AbiFAVSU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jun 2022 17:18:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231192AbiFAVSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 17:18:18 -0400
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 414516B0B5;
        Wed,  1 Jun 2022 14:18:17 -0700 (PDT)
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-edeb6c3642so4405608fac.3;
        Wed, 01 Jun 2022 14:18:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=o5pwFUhu/FPI8tEhMHY532uv0xZCQ4oRTlsOR80fCo8=;
        b=rlHVi4t+Wj0rARHeKiGJ5NF5XqwYUd1OsCsdAE8BR1LNzGxYXxOGNhB3Sg3+91YX8P
         G1lEFGnIAW9nS8HXJCacuL2PBGHUDnHCLQePJqfAL7pT0MsNqUNgNaZP5kgNTfNhouYT
         E/fkeRIdv2XgKHWaSOgNu64MjdeBt9E7LuJDe5h5Y16p3MKQcmwv+iZxxmhrytxFqND+
         a6TjTM6KsgAQQ5A+2qYTFqMpm9c3htoGAH34FEQRygDZJzbliFSqNAIleRpLtGOBbeIx
         yZgD/Xy4/xQuQy+OXPBgP8F1+BLwW41RF/q53kPhOFP+yAkogsW/WwklEx/jMHG2CvBg
         OoUg==
X-Gm-Message-State: AOAM533SRfYIUnlqQieC+725zw9JIaT/IXOo72Rb2QiwoP4OrOxb4CXG
        XyEIlsUJeE5qWjHLjPAgrg==
X-Google-Smtp-Source: ABdhPJwt1M0vDmBM+bRqsOtNVzG+9f9T4L1x+/T31QwiuGn+0l29gve72nwLdI3wKDIEnsfFkRY0sg==
X-Received: by 2002:a05:6870:4620:b0:f2:5d2b:996e with SMTP id z32-20020a056870462000b000f25d2b996emr949069oao.68.1654118296555;
        Wed, 01 Jun 2022 14:18:16 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id q10-20020a056870328a00b000f32b1982f1sm1152892oac.46.2022.06.01.14.18.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 14:18:16 -0700 (PDT)
Received: (nullmailer pid 472575 invoked by uid 1000);
        Wed, 01 Jun 2022 21:18:15 -0000
Date:   Wed, 1 Jun 2022 16:18:15 -0500
From:   Rob Herring <robh@kernel.org>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        devicetree@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] dt-bindings: interrupt-controller/uniphier-aidet:
 Add bindings for NX1 SoC
Message-ID: <20220601211815.GA472514-robh@kernel.org>
References: <1653023822-19229-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1653023822-19229-2-git-send-email-hayashi.kunihiko@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1653023822-19229-2-git-send-email-hayashi.kunihiko@socionext.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 May 2022 14:17:01 +0900, Kunihiko Hayashi wrote:
> Update uniphier-aidet binding document for UniPhier NX1 SoC.
> 
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  .../bindings/interrupt-controller/socionext,uniphier-aidet.yaml  | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
