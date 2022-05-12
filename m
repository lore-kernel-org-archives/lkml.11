Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99A76C433FE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 May 2022 15:27:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355930AbiELP1d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 May 2022 11:27:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355935AbiELP1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 11:27:25 -0400
Received: from relay12.mail.gandi.net (relay12.mail.gandi.net [217.70.178.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E386E6B654
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 08:27:23 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 287B020000D;
        Thu, 12 May 2022 15:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1652369242;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CqboCWzVkcmkkQi3DnBuxah5KaOTeztT0z2EnIjbHQ8=;
        b=Xdvmg6pzHeRMTnAMPovYZSHEQ8yc0Ie92xefxgAXgyGelzOuSwfRDYvW2Xq37O4iOf3qUH
        BZZhTdZQDdHbQJjNY0FZWeOWS1kyiFelWhrqPwPgk09zpnyDalv6qaEobQtDrUANdIoiyB
        XIc5F1B6R/AkXYSN8cvtSsMlnzGCraJbfrav+8GnZXwlWMRxrCCe2eJiXkLe+qP4UWAuT4
        DpkcaSjCaaLCYha/4QZ8BZGLb/SrNbcl7N5SsZ9ahsqh8aHa+JnG3rlUs2+e3T2C/ePUhn
        VxpX7tw5cXqrOah+OVxljewtGQR1loQLr548DMIfv6sQ9kDy4eu+Birqk6KmVQ==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Mikhail Zhilkin <csharper2005@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Hauke Mehrtens <hauke@hauke-m.de>,
        NOGUCHI Hiroshi <drvlabo@gmail.com>,
        INAGAKI Hiroshi <musashino.open@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        Karim <Karimdplay@gmail.com>, M <x1@disroot.org>
Subject: Re: [PATCH v3 3/3] mtd: parsers: add support for Sercomm partitions
Date:   Thu, 12 May 2022 17:27:20 +0200
Message-Id: <20220512152720.244806-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220503155140.2339899-1-csharper2005@gmail.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'4213e556fe2a18782e91a87fec70d98c48f1ee41'
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-05-03 at 15:51:40 UTC, Mikhail Zhilkin wrote:
> This adds an MTD partition parser for the Sercomm partition table that
> is used in some Beeline, Netgear and Sercomm routers.
> 
> The Sercomm partition map table contains real partition offsets, which
> may differ from device to device depending on the number and location of
> bad blocks on NAND.
> 
> This is essentially the same code as proposed by NOGUCHI Hiroshi:
> Link: https://github.com/openwrt/openwrt/pull/1318#issuecomment-420607394
> 
> Signed-off-by: NOGUCHI Hiroshi <drvlabo@gmail.com>
> Signed-off-by: Mikhail Zhilkin <csharper2005@gmail.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next, thanks.

Miquel
