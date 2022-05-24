Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4232C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 24 May 2022 15:15:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238736AbiEXPPW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 May 2022 11:15:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbiEXPPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 11:15:19 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C5C18AE48;
        Tue, 24 May 2022 08:15:18 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 828A31F42456
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1653405317;
        bh=Iy3W7rUkg3Wow+MZYHzeedJhzvCA8F8HfCiBIaNRcSg=;
        h=From:To:Cc:Subject:Date:From;
        b=LzoGjsp25sHcTcIYJViMp7m2j6vnZuvi4sm3nrlS35epZfkDtMwnny6NOI/sxz9dz
         NOcYDskKVd19p0bCZKDqjOdtrEXjbXKy/4kajTDsE+CsJ4Gc3PLEpEgTeqfE9Wu3Zc
         hLdCRghmeF6cM/JekAX5BRAONvqraYEunuKK5KDTEFrfPnavCZXRShLk+pNE8bquTc
         k8vyCX4ucyaKw6b72Mds2yaZAQ+bTULriIO07qtpy0XLJAsL7Rmh0CYTuQ+lFvMvte
         YE+8fHnkAsmW45qLEDGWflkXTQR07JdFTpl1YgE7IoqeGH8wdr6e5Iw5OgH5BiN7tV
         68OTzC0AaAIYA==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     jassisinghbrar@gmail.com
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, houlong.wei@mediatek.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v2 0/2] MediaTek GCE json-schema and multi-gce clocks
Date:   Tue, 24 May 2022 17:15:10 +0200
Message-Id: <20220524151512.247435-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v1 of "dt-bindings: mailbox: mtk-gce: Convert txt to json-schema"
exposed some readability issues for the mtk-cmdq-mailbox driver but,
upon further inspection, I've found that there is a shorter way to
achieve the Multi-GCE support as it's limited to simply managing two
clocks instead of one.

This series converts the mtk-gce freeform documentation to json-schema
and adds a second clock for the dual-gce (multi-gce) case, as to stop
looking for aliases in the entire devicetree to get clocks from the
secondary GCE node: declaring both clocks on both nodes is simply the
right thing to do, as operating one GCE Mailbox requires both clocks
to be enabled, since there may be interop between the two GCEs.

For now, the only Dual-GCE SoC is MT8195, for which no devicetree is
upstream yet.

AngeloGioacchino Del Regno (2):
  dt-bindings: mailbox: mtk-gce: Convert txt to json-schema
  mailbox: mtk-cmdq-mailbox: Simplify getting multi-gce clocks

 .../bindings/mailbox/mediatek,gce-mbox.yaml   | 124 ++++++++++++++++++
 .../devicetree/bindings/mailbox/mtk-gce.txt   |  82 ------------
 drivers/mailbox/mtk-cmdq-mailbox.c            |  32 +----
 3 files changed, 131 insertions(+), 107 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mailbox/mediatek,gce-mbox.yaml
 delete mode 100644 Documentation/devicetree/bindings/mailbox/mtk-gce.txt

-- 
2.35.1

