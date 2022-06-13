Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6566CCA480
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jun 2022 19:20:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346763AbiFMTT6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jun 2022 15:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350190AbiFMTTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 15:19:04 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E76DB27FD5;
        Mon, 13 Jun 2022 10:16:05 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id o6-20020a17090a0a0600b001e2c6566046so9440972pjo.0;
        Mon, 13 Jun 2022 10:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=75IveQMXgvk79tHEqzNIp5A8iiI43QaZAPn0brlQYVw=;
        b=ODtTsinUVuMW+Dz1Wqvv399CbXVdRhkhKjlUxJZZkj68AJaHsu6vgNwXAuLQv/7sng
         UFCtGalI4eIGm8kDpdONgSFcMXHvqOGwh3IZDY2YHDYy7HE5B40Bg9+UZUK6HHCW/fMX
         99azOt7yIiAalpaZzvjeo4Ex70dHEBbbaShYUGLzx8cAmffdR6idYC/PNg52Nv/PjyYE
         6DY3HPxl27x+9tVXC6rqAJFydohr1Gx7M3VWpdjHh5b9TNHQatDumjN/zaNGW2LqF8rD
         BNEnENN0SxslgZRWugUMou7pmi86zykFEhEpD5MuREqeStnDaplpOCBbSHKnucoOGNR+
         UOBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=75IveQMXgvk79tHEqzNIp5A8iiI43QaZAPn0brlQYVw=;
        b=vpU1d9ux8H6CUg1XWmeNdYGkX/7fnTpv5S2I4S++WSl37BYIW+NDt0NkL5EeYnndqv
         eeX2y58RE9oHdVDeK3di1L3EXRN+vJm6R1kjsxV28PuArGVpfQmm5S3MM3SoHhf38sOS
         4X/rl0WxAi/fsRR0R6NLC5TOF6oXOHtaeVpRD6jBSlpv2BNdvZEgAyGZf/6YGN3arIzI
         6VZOD0CkZjDq+dQGVqxUAM8P0+XFyR5hRXytkNknRo7FzqltUhL+RXm9vO89EHqVptx9
         ag/cYdCaonIN3vM17dT6DBVc71tBAe6oYAAmAU9u9afPnVl/ad0Pq2yMbphr8Fciqpzj
         T32g==
X-Gm-Message-State: AJIora9pvl9V3U2VoNfLKmcYX6BPgPU/tFKe9qC282QITz9IsbdH0xZD
        0b/2Di7pPD4iP/GCyPP4JnKurB2ZVxM=
X-Google-Smtp-Source: AGRyM1vKahAohmV19iY+hhuK3jdGPvQmCZVuHJrIWMElyPDFItG4R6Ah2ZEXa4ux0NXfszLNbXVBGg==
X-Received: by 2002:a17:902:e353:b0:168:9a78:25cb with SMTP id p19-20020a170902e35300b001689a7825cbmr59465plc.13.1655140565250;
        Mon, 13 Jun 2022 10:16:05 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id c62-20020a633541000000b003fd12b703e5sm5765740pga.49.2022.06.13.10.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 10:16:04 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        William Zhang <william.zhang@broadcom.com>,
        Linux ARM List <linux-arm-kernel@lists.infradead.org>
Cc:     tomer.yacoby@broadcom.com, anand.gore@broadcom.com,
        dan.beygelman@broadcom.com, philippe.reynes@softathome.com,
        samyon.furman@broadcom.com, kursad.oney@broadcom.com,
        joel.peshkin@broadcom.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: arm: Add BCM6756 SoC
Date:   Mon, 13 Jun 2022 10:16:03 -0700
Message-Id: <20220613171603.241670-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220608175629.31538-2-william.zhang@broadcom.com>
References: <20220608175629.31538-1-william.zhang@broadcom.com> <20220608175629.31538-2-william.zhang@broadcom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  8 Jun 2022 10:56:27 -0700, William Zhang <william.zhang@broadcom.com> wrote:
> Add BCM6756 SoC device tree description to bcmbca binding document.
> 
> Signed-off-by: William Zhang <william.zhang@broadcom.com>
> ---

Applied to https://github.com/Broadcom/stblinux/commits/devicetree/next, thanks!
--
Florian
