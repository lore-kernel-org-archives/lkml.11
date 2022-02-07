Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F38AC35273
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Feb 2022 15:44:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384653AbiBGPnp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Feb 2022 10:43:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357261AbiBGPjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 10:39:49 -0500
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DB12C0401CF;
        Mon,  7 Feb 2022 07:39:48 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 3DC37FF80D;
        Mon,  7 Feb 2022 15:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1644248383;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=owOcAnjX+PJ5g3z0qRPYwI6jTUZoFW3Nfrfu/H3vrD0=;
        b=aIbasiSxXW919EnFmj2qVO8RrHjkgKrcNjkoyUyod4BNWjeS+yZuJxDpJKGBzzQAVmuca0
        YWqaANRpQVinaLj362eWF4Dv5voxkt/SpWZCivbRLGZqg5kdosfTz0UpAfPvXPeIVJIBLz
        ZgxDD7WdlSo5ciKA7Vt9DjXbwjUSenVuf2XqSZtnQgjuqSgQUErmbYDhYoSYY4A3v5iNyu
        UoMYAfnZKk1boS5KnFdiIdfd/kmwJnJ1yA3Y8cU47bUAbW7xNqzBN3TxYk4U7wF2/hosU5
        agNl+nJnLrjQi5rRG6JeCSeF1Yyvf5reN3pLE41sE71/9UwahxL3J7zlan5Anw==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Sean Nyekjaer <sean@geanix.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>
Cc:     stable@vger.kernel.org,
        Boris Brezillon <boris.brezillon@collabora.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mtd: rawnand: protect access to rawnand devices while in suspend
Date:   Mon,  7 Feb 2022 16:39:40 +0100
Message-Id: <20220207153940.710464-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220131215138.2013649-1-sean@geanix.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'0ff4eb01ffb923d68e086cb817f173c7464ac6e9'
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-01-31 at 21:51:38 UTC, Sean Nyekjaer wrote:
> Prevent rawnend access while in a suspended state.
> 
> Commit 013e6292aaf5 ("mtd: rawnand: Simplify the locking") allows the
> rawnand layer to return errors rather than waiting in a blocking wait.
> 
> Tested on a iMX6ULL.
> 
> Fixes: 013e6292aaf5 ("mtd: rawnand: Simplify the locking")
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
