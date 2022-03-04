Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52FD4C433FE
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Mar 2022 08:43:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234692AbiCDIn7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Mar 2022 03:43:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233982AbiCDInv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 03:43:51 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F5F366213
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 00:43:03 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id z4so6925686pgh.12
        for <linux-kernel@vger.kernel.org>; Fri, 04 Mar 2022 00:43:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=627oPX+DGtF7Etph+slPCYuLirVFFqbCgoAmIZxqGeU=;
        b=I0HXhO/3K8UuqLVrztTJgmhaBUIPbKnovpiChW/NN5AezpTnub6VbY5mKHRvvfRjru
         G+vBXiCBmMz0X3G7juB7Idt5QInixPjIkUvWYfUlU5p8zJjXe2nE3MHRSQl/YO1OsNxy
         01qAI59ttIHtR18puIJqbxM+vL3htOAwIIm42MNnTsR0/pFKQVP66+eqMXyduTQz7BWa
         q7dW/fXRbReesYR6GX+ZCQ6B9Zt/oaRei7U8dFeozAt+qWn0dXmS6qJTZiv3uyA3d3fT
         TVb8j0JdhaybHLiQRzp76BenikuJazLakYKvbCBFS0gTkClqrN/NkR0IR/jd2cTTJOqV
         /hOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=627oPX+DGtF7Etph+slPCYuLirVFFqbCgoAmIZxqGeU=;
        b=phkRzR5UODNHEAOWdjGE8jdUT1SNxXa/ueFqrjXTIssy6XLKCL34aV+m/YFNt/DWEI
         Z3qLUMBv60w26vhTzXukZQXm8/tdKWCsIEd9I2mRrdneIPRYLeyV+0caSkW6KxpxEs/7
         zOzzBJmV6VomDMbnVFrQmxzmvjGrnZpyBQ6MGpPEEeJrLEvCzaV0a9cutu/krSCKzxIv
         1MYtVnDiEM7PPmQPkdveHp3n2vAn5s0467VjB3DZGoBIc1P8D92P0uL0UXD/gvKMy867
         Xspm6Yws2lel0hAl5qrWETd3Hlo9nLFwgw1Zr8PdU9WZreQFVQcLmYa+6vNJvGHkdrN4
         8FiQ==
X-Gm-Message-State: AOAM5330jQse6wMVV4gGXKPTvkmqdMkjRGkkpyOmf0pNlNNiMOOjjWND
        7odFvPi1wVVkAlah9aPq+Ggb0A==
X-Google-Smtp-Source: ABdhPJxnV4KLbyp0FJrKDpT92no2nDhKFhhX91+K9egKuVha8hnOjoG9bpvulilLCZYFEFOECTCPtg==
X-Received: by 2002:a63:8bc4:0:b0:341:760f:44d8 with SMTP id j187-20020a638bc4000000b00341760f44d8mr33584865pge.32.1646383382940;
        Fri, 04 Mar 2022 00:43:02 -0800 (PST)
Received: from hsinchu16.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id mu1-20020a17090b388100b001bedddf2000sm4245191pjb.14.2022.03.04.00.42.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 00:43:02 -0800 (PST)
From:   Zong Li <zong.li@sifive.com>
To:     robh+dt@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, krzysztof.kozlowski@canonical.com,
        conor.dooley@microchip.com, geert@linux-m68k.org,
        bin.meng@windriver.com, green.wan@sifive.com, vkoul@kernel.org,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Cc:     Zong Li <zong.li@sifive.com>
Subject: [PATCH v6 0/3] Determine the number of DMA channels by 'dma-channels' property
Date:   Fri,  4 Mar 2022 16:42:54 +0800
Message-Id: <cover.1646383150.git.zong.li@sifive.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PDMA driver currently assumes there are four channels by default, it
might cause the error if there is actually less than four channels.
Change that by getting number of channel dynamically from device tree.
For backwards-compatible, it uses the default value (i.e. 4) when there
is no 'dma-channels' information in dts.

This patch set contains the dts and dt-bindings change.

Changed in v6:
 - Rebase on tag v5.17-rc6
 - Change sf_pdma.chans[] to a flexible array member.

Changed in v5:
 - Rebase on tag v5.17-rc3
 - Fix typo in dt-bindings and commit message
 - Add PDMA versioning scheme for compatible

Changed in v4:
 - Remove cflags of debug use reported-by: kernel test robot <lkp@intel.com>

Changed in v3:
 - Fix allocating wrong size
 - Return error if 'dma-channels' is larger than maximum

Changed in v2:
 - Rebase on tag v5.16
 - Use 4 as default value of dma-channels

Zong Li (3):
  dt-bindings: Add dma-channels property and modify compatible
  riscv: dts: Add dma-channels property and modify compatible
  dmaengine: sf-pdma: Get number of channel by device tree

 .../bindings/dma/sifive,fu540-c000-pdma.yaml  | 19 +++++++++++++--
 .../boot/dts/microchip/microchip-mpfs.dtsi    |  3 ++-
 arch/riscv/boot/dts/sifive/fu540-c000.dtsi    |  3 ++-
 drivers/dma/sf-pdma/sf-pdma.c                 | 24 ++++++++++++-------
 drivers/dma/sf-pdma/sf-pdma.h                 |  8 ++-----
 5 files changed, 39 insertions(+), 18 deletions(-)

-- 
2.31.1

