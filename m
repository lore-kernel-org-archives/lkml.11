Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3988CCCA473
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jun 2022 14:48:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239233AbiFIOsC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jun 2022 10:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234782AbiFIOr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 10:47:59 -0400
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4BEB392;
        Thu,  9 Jun 2022 07:47:58 -0700 (PDT)
Received: by mail-io1-f42.google.com with SMTP id s23so22334309iog.13;
        Thu, 09 Jun 2022 07:47:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MmnNTExaxw9cDUZ7hmJtSWrFL/lce9Zc3gR/1R2SlYM=;
        b=Rt1rJ0vE1mozZvR78C4kKKMeTjsx6G6UdDt1BfNx4jgJ5v5OsViEH+HOsUgeYSVFSM
         VqKSXoleDFcdF/PEyYiD2AjXGp3PderQS2nB7Bw0gm0B+u4rB8NEKuGO+KAXDNNI0vjJ
         GxYZfzPnMMLHgs54FhLHlTJVNNpqhB8bbNk9YW2Acrp3FGYs6xj+I7Dh9KpgCzrkGa+P
         6Q9dqOdlK0wNbxKhmzM0RlSNM0hH9HuuCoioyBDA/Sb23pDdPKpKzqkY1PCSKbCW3fiQ
         uCbTZ4lb9ld+OM+rw5nOHo/HJC7hWGsBshZaPUFXGP0ywgaqHJ9KCVIQFS5iQ1TwkGLa
         /kiw==
X-Gm-Message-State: AOAM530zjiSdITwgTR/soIk7cUTnAia0UODPbEmbzfFADeRlkWBnKum9
        YA+dhUqi51hFI9dFEmakTT+plf6C6Q==
X-Google-Smtp-Source: ABdhPJzcACIf+8Emj+UtAWrFqU4FWmDwFwEQILum1iK5InoKs05v/q6qLfvTrfmb8lJtZBDApVvROg==
X-Received: by 2002:a05:6638:140d:b0:331:aaf6:658b with SMTP id k13-20020a056638140d00b00331aaf6658bmr12333399jad.21.1654786077850;
        Thu, 09 Jun 2022 07:47:57 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id p16-20020a5d9850000000b006656ea096b0sm9450849ios.6.2022.06.09.07.47.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 07:47:57 -0700 (PDT)
Received: (nullmailer pid 3771723 invoked by uid 1000);
        Thu, 09 Jun 2022 14:47:54 -0000
Date:   Thu, 9 Jun 2022 08:47:54 -0600
From:   Rob Herring <robh@kernel.org>
To:     William Zhang <william.zhang@broadcom.com>
Cc:     tomer.yacoby@broadcom.com, linux-kernel@vger.kernel.org,
        joel.peshkin@broadcom.com, devicetree@vger.kernel.org,
        philippe.reynes@softathome.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        kursad.oney@broadcom.com, dan.beygelman@broadcom.com,
        samyon.furman@broadcom.com,
        Linux ARM List <linux-arm-kernel@lists.infradead.org>,
        anand.gore@broadcom.com, f.fainelli@gmail.com,
        Rob Herring <robh+dt@kernel.org>,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>
Subject: Re: [PATCH 1/3] dt-bindings: arm: Add BCM6756 SoC
Message-ID: <20220609144754.GA3771621-robh@kernel.org>
References: <20220608175629.31538-1-william.zhang@broadcom.com>
 <20220608175629.31538-2-william.zhang@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220608175629.31538-2-william.zhang@broadcom.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 08 Jun 2022 10:56:27 -0700, William Zhang wrote:
> Add BCM6756 SoC device tree description to bcmbca binding document.
> 
> Signed-off-by: William Zhang <william.zhang@broadcom.com>
> ---
> 
>  Documentation/devicetree/bindings/arm/bcm/brcm,bcmbca.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
