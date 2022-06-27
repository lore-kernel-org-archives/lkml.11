Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5ADFC43334
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jun 2022 22:29:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242613AbiF0W3G (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jun 2022 18:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239652AbiF0W3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 18:29:01 -0400
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 369C61A056;
        Mon, 27 Jun 2022 15:29:01 -0700 (PDT)
Received: by mail-io1-f50.google.com with SMTP id u20so11129548iob.8;
        Mon, 27 Jun 2022 15:29:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=M7JsswKtKFMmct/59/l3KSgs3sKO9aTj7Vg2773Jtg8=;
        b=SGQtkhBTr+qatYza4HSWSUbATWEr7D2bXNYh6rOu6+idHVJfJI7yTsNYcjpMvlfu3z
         iLheei14ZxWiUjV6tBqDTqb9EEem8U6pZnF6AbKTw0ohHvcIi0fV71rpLKDlwnsyL1b5
         oAGxABbcIGkTZvhe0AoYIgbVSOGu3XGAiunvVCcUBZ2de8tIXlShg6Izw2qYyc0Ef9Yx
         fYdU/KDjKFl1Sdm6kX7BXRHTBOV3wdd/fBi8qRx5kDiATvvktGUvGPNVvENhbfvslVEL
         tmH8ImrV4vi4S9YyrmLtF2ToPWXd7EVSpZsChQr6g1Uz+ImcaERGqKbYciQZ7cCZgm+9
         KzjA==
X-Gm-Message-State: AJIora8Tjadlm5nNOyNOxc2INJEir0H8bnmMRuKdp6QjrqzA//iPZzwb
        647j+tMvpXTjsD3Tky28cw==
X-Google-Smtp-Source: AGRyM1s5cyucj24BXjf2ZzIwSpTRK+LqWKYr3SfB5a36Pzs8Y0301ZfisVKbg0gnNo7Gx6l14bDoAw==
X-Received: by 2002:a05:6638:38a0:b0:331:ec50:d191 with SMTP id b32-20020a05663838a000b00331ec50d191mr9258099jav.40.1656368940397;
        Mon, 27 Jun 2022 15:29:00 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id j194-20020a0263cb000000b00331f8fff9a3sm5266869jac.64.2022.06.27.15.28.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 15:28:59 -0700 (PDT)
Received: (nullmailer pid 3081821 invoked by uid 1000);
        Mon, 27 Jun 2022 22:28:58 -0000
Date:   Mon, 27 Jun 2022 16:28:58 -0600
From:   Rob Herring <robh@kernel.org>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org, vkoul@kernel.org,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kishon@ti.com
Subject: Re: [PATCH v4 1/2] dt-bindings: phy: add Amlogic G12A Analog MIPI
 D-PHY bindings
Message-ID: <20220627222858.GA3081761-robh@kernel.org>
References: <20220616133811.1674777-1-narmstrong@baylibre.com>
 <20220616133811.1674777-2-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220616133811.1674777-2-narmstrong@baylibre.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Jun 2022 15:38:10 +0200, Neil Armstrong wrote:
> The Amlogic G12A SoCs embeds an Analog MIPI D-PHY to communicate with DSI
> panels, this adds the bindings.
> 
> This Analog D-PHY works with a separate Digital MIPI D-PHY.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  .../phy/amlogic,g12a-mipi-dphy-analog.yaml    | 35 +++++++++++++++++++
>  1 file changed, 35 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/amlogic,g12a-mipi-dphy-analog.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
