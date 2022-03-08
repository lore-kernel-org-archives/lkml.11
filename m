Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A02CCC433EF
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Mar 2022 19:43:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347984AbiCHToH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Mar 2022 14:44:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344473AbiCHToF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 14:44:05 -0500
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61D1038DBC;
        Tue,  8 Mar 2022 11:43:08 -0800 (PST)
Received: by mail-oo1-f54.google.com with SMTP id y27-20020a4a9c1b000000b0032129651bb0so263841ooj.2;
        Tue, 08 Mar 2022 11:43:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=2pNVkw2O4MogMAq4jHIFwlqhZv9BXG1M2wr/av8wc0U=;
        b=5fmjgqeQLLewNibVcFEpejC3HljaPcYPkWC+/Jf3hgNCMz6D3/JZuVBZ7cQnyz51hd
         5nK+cOZdsmanx877zsjdr4uwx4nmvZEiqKh46fa/VSKv0WFRldf2P+qjSuZagzuMvRDe
         KjngEyB7B1TSdh2c3NiYWa5GZO7Twj/Wk05dWevLrk9UlDNZfDp7ligrK2UjZXeO01ua
         CnOvHtLUVn1OLb/MldVQF6Zq8GifeAmdx/z6FReH8fa+j1t5xYm1QqtMCuoDqb4zTLgo
         zFCL4xeeDF0duKUKUDfo9LRskC0iyr/8wACvPwBpGlVpThZY/7/KeoeIWdktTy/6fXam
         Jlng==
X-Gm-Message-State: AOAM530fPlBjqhGCtUwdff8qJ2wBMGb1KIJ18bkWll0CqZX+XzrJpq9S
        evtzu3AfJQiy8cKQnWsR7Q==
X-Google-Smtp-Source: ABdhPJyr51kvJkKJU5/H9gq4cqrtCiTe93NGryR8JfOOumqEu0fUQVdEe0UP0F+8B5XsyhBYRIermQ==
X-Received: by 2002:a05:6870:e0ce:b0:da:b3f:2b31 with SMTP id a14-20020a056870e0ce00b000da0b3f2b31mr3486762oab.208.1646768587714;
        Tue, 08 Mar 2022 11:43:07 -0800 (PST)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id a23-20020a056830101700b005ad0bd6fe0csm8286135otp.47.2022.03.08.11.43.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 11:43:06 -0800 (PST)
Received: (nullmailer pid 1227241 invoked by uid 1000);
        Tue, 08 Mar 2022 19:43:06 -0000
Date:   Tue, 8 Mar 2022 13:43:06 -0600
From:   Rob Herring <robh@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [GIT PULL] Devicetree fixes for v5.17, take 3
Message-ID: <YiexypCIC3q8dHPZ@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull 2 more fixes for v5.17.

Rob


The following changes since commit 0c0822bcb73f154d96ee648644ec5a8628e3b864:

  dt-bindings: update Roger Quadros email (2022-02-22 16:06:31 -0600)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-5.17-3

for you to fetch changes up to f6eafa4022dd61e029205bea4d4147d26e69fef2:

  dt-bindings: phy: ti,tcan104x-can: Document mux-states property (2022-03-08 10:41:32 -0600)

----------------------------------------------------------------
Devicetree fixes for v5.17, take 3:

- Fix pinctrl node name warnings in examples

- Add missing 'mux-states' property in ti,tcan104x-can binding

----------------------------------------------------------------
Aswath Govindraju (1):
      dt-bindings: phy: ti,tcan104x-can: Document mux-states property

Rob Herring (1):
      dt-bindings: mfd: Fix pinctrl node name warnings

 Documentation/devicetree/bindings/mfd/brcm,cru.yaml          | 4 ++--
 Documentation/devicetree/bindings/mfd/cirrus,lochnagar.yaml  | 6 +++---
 Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml   | 7 +++++++
 Documentation/devicetree/bindings/pinctrl/cirrus,madera.yaml | 3 ---
 4 files changed, 12 insertions(+), 8 deletions(-)
