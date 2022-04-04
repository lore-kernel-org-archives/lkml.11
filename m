Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBEFBC433EF
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Apr 2022 08:47:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240106AbiDDIth (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Apr 2022 04:49:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240609AbiDDItd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 04:49:33 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 628043B56E
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 01:47:34 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id C2C3E1BF209;
        Mon,  4 Apr 2022 08:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1649062052;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HNAxKX1DSgvz6AgiA/E8PDeYrkr/tq8/0jpvO7zkYKA=;
        b=MWyMzEJux6rUSkSI4iNvYHWv4pptdpWTTAYtJtnj4JYhcFk2awEYuxWRvofXaFDY5GqpqL
        Reef/ZEeNPsMTmdf6OEp1/CI4ZnnCT3Xo3q2yyMks0DnOB/32eLObnJjQvkSk23aXOfmQW
        ycmRuTH3eR2LKXQ4xW09xx/nyP9krkRg/4XwZebyPwaW99ojZoquI4ENd5EeGF5axZF34x
        zTTvmOpzrSDFogMtxoFxCIV5uHrLPxpdgmggi1Jp6zxNk/tUF15cAmfaUdZqsToIOCrOr1
        WxgUAu52/YJpkI+bWj1Uh3XQjcqiN9pgYB5ppuVj3K1qxKntMg5X4c86gf0xhQ==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Wang Weiyang <wangweiyang2@huawei.com>, miquel.raynal@bootlin.com,
        richard@nod.at, vigneshr@ti.com, paul@crapouillou.net
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] mtd: rawnand: davinci: Remove redundant unsigned comparison to zero
Date:   Mon,  4 Apr 2022 10:47:30 +0200
Message-Id: <20220404084730.1203812-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220317113907.96006-1-wangweiyang2@huawei.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'6425dd136ddc40fc434156d1957a3adb367dd874'
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-03-17 at 11:39:07 UTC, Wang Weiyang wrote:
> Since core_chipsel is uint32_t, comparison to zero is redundant
> 
> Signed-off-by: Wang Weiyang <wangweiyang2@huawei.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
