Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57723C35270
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Feb 2022 03:03:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244021AbiBIDCp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Feb 2022 22:02:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359851AbiBIC4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 21:56:47 -0500
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7545C0613CC;
        Tue,  8 Feb 2022 18:56:46 -0800 (PST)
Received: by mail-oo1-f52.google.com with SMTP id v17-20020a4ac911000000b002eac41bb3f4so933063ooq.10;
        Tue, 08 Feb 2022 18:56:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YzpZJPyikOSmfz29HT3JMH8XzgvRS7QzufEjx8g74Lg=;
        b=dYGbN8AqTwwCgki+KGOjHcqQNiQOUQz8+WDmJjhEJVK4LX9TyLrYCUOTpr/Aft23Wz
         IJtJLhbL1fefm0vopTfDam7AZo9r9tZs2hKx14lLm2TjVWI9PMfQyja+PrZphN+FYUKo
         UVH2UbXLWIdXrV4Qp/koCGJVcLUprO9lOgWDaGhSNyWWswMiCL0lB68wt0zUhdcTU8Ya
         7EfkkmeSSRGrbouU3ysEM9gtkY6UlTn0keoQTpnuy3zuTK/oB1e1ig71VeJ+JEF9FwKd
         usc897mxMkOdBfdxxUZe4abb6ni6cWYF4cEBznkbMhMAcRO0Fn568i8qKliuiHB+aSce
         lItg==
X-Gm-Message-State: AOAM533DmpR13ZXNxlP4UbXgAF8pzGA6o/1nZfoakKnWDKXBu0vEIf1R
        AdjYXG1V8+CksBLZ5epPiQ==
X-Google-Smtp-Source: ABdhPJx8V3Vh8nhOYS4sySuQMAt/hoYl9LLCFpXg/dcy/NCynV7bBxJjvdGsbHXMbzDyhHAgT6q25A==
X-Received: by 2002:a05:6870:1116:: with SMTP id 22mr95514oaf.302.1644375405988;
        Tue, 08 Feb 2022 18:56:45 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id b7sm6125944ooq.30.2022.02.08.18.56.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 18:56:45 -0800 (PST)
Received: (nullmailer pid 3530627 invoked by uid 1000);
        Wed, 09 Feb 2022 02:56:44 -0000
Date:   Tue, 8 Feb 2022 20:56:44 -0600
From:   Rob Herring <robh@kernel.org>
To:     Zong Li <zong.li@sifive.com>
Cc:     mturquette@baylibre.com, lee.jones@linaro.org, robh+dt@kernel.org,
        palmer@dabbelt.com, linux-riscv@lists.infradead.org,
        paul.walmsley@sifive.com, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        sboyd@kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: change the macro name of prci in header
 files and example
Message-ID: <YgMtbBdt1RkHcqoa@robh.at.kernel.org>
References: <cover.1642582832.git.zong.li@sifive.com>
 <81d9a152e65374117b633f953aa31f378412acb5.1642582832.git.zong.li@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <81d9a152e65374117b633f953aa31f378412acb5.1642582832.git.zong.li@sifive.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Jan 2022 17:28:38 +0800, Zong Li wrote:
> We currently change the macro name for fu540 and fu740 by adding the
> prefix respectively, the dt-bindings should be modified as well.
> 
> Signed-off-by: Zong Li <zong.li@sifive.com>
> ---
>  .../devicetree/bindings/gpio/sifive,gpio.yaml  |  2 +-
>  .../bindings/pci/sifive,fu740-pcie.yaml        |  2 +-
>  .../bindings/serial/sifive-serial.yaml         |  2 +-
>  include/dt-bindings/clock/sifive-fu540-prci.h  |  8 ++++----
>  include/dt-bindings/clock/sifive-fu740-prci.h  | 18 +++++++++---------
>  5 files changed, 16 insertions(+), 16 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
