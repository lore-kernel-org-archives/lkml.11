Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7793EC433EF
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Mar 2022 14:16:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243117AbiCGORV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Mar 2022 09:17:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243082AbiCGORL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 09:17:11 -0500
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 695838EB44;
        Mon,  7 Mar 2022 06:16:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1646662575;
  x=1678198575;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ICzA0DrdXMhOKFRda00jGMuRSZtr/qRb9e8msUmDl9E=;
  b=qHi/7dFUGGWC3m5upjoZ21XTbq8L8F/Y+zQYwtkAwvXqwRpTznDITA0r
   VSvdZdrjDKihXwhQ4rsWC+X4Tjctlx/+NCeQGxWPWlBI7uN//CjJnImlw
   uhhWlwfnzlEFcNrWvF6uxey4E1DuGNeT+wdCgqRUwtlmE4kTAwYPvGk7V
   xys7u2AyFZLZC52677GxRbigh1xl6RoxqkZvKsxlRag1OE7qQbuhdyYwj
   pT6XUqpvTjnRnEsiXA5eis1RvGSxZRO/ig0rrM7gflTvUJeSQR96eSeYs
   r7STMBOKDSeDa+AioGf5HYn7po7u03N7ygX7BHhHY169B6dGhd0R/kYhB
   Q==;
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     <vigneshr@ti.com>, <richard@nod.at>, <miquel.raynal@bootlin.com>,
        <joern@lazybastard.org>
CC:     <kernel@axis.com>, <linux-kernel@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <frowand.list@gmail.com>, <krzysztof.kozlowski@canonical.com>,
        <robh+dt@kernel.org>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>
Subject: [PATCH 0/4] mtd: phram improvements
Date:   Mon, 7 Mar 2022 15:15:45 +0100
Message-ID: <20220307141549.2732179-1-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The phram driver in the MTD subsystem can be used to allow the kernel to use an
MTD or (via mtdblock) a block device in RAM (with the contents loaded by a
bootloader for example).  This series has some improvements to make it more
usable by adding device tree support and to significantly improve its
performance by using cached mappings when possible.

Vincent Whitchurch (4):
  mtd: core: Check devicetree alias for index
  dt-bindings: reserved-memory: Add phram
  mtd: phram: Allow probing via reserved-memory
  mtd: phram: Allow cached mappings

 .../bindings/reserved-memory/phram.yaml       | 45 +++++++++++
 drivers/mtd/devices/phram.c                   | 78 +++++++++++++++++--
 drivers/mtd/mtdcore.c                         | 11 ++-
 drivers/of/platform.c                         |  1 +
 4 files changed, 127 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/reserved-memory/phram.yaml

-- 
2.34.1

