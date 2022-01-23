Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82775C433F5
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jan 2022 15:31:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237685AbiAWPbs (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jan 2022 10:31:48 -0500
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:53113 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237676AbiAWPbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 10:31:47 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id B5981FF802;
        Sun, 23 Jan 2022 15:31:42 +0000 (UTC)
Date:   Sun, 23 Jan 2022 16:31:40 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Harvey Hunt <harveyhuntnexus@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mips@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: rawnand: ingenic: Fix missing put_device in
 ingenic_ecc_get
Message-ID: <20220123163140.557a251b@xps13>
In-Reply-To: <20220123152332.529757-1-miquel.raynal@bootlin.com>
References: <20211230072751.21622-1-linmq006@gmail.com>
        <20220123152332.529757-1-miquel.raynal@bootlin.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


miquel.raynal@bootlin.com wrote on Sun, 23 Jan 2022 16:23:32 +0100:

> On Thu, 2021-12-30 at 07:27:51 UTC, Miaoqian Lin wrote:
> > If of_find_device_by_node() succeeds, ingenic_ecc_get() doesn't have
> > a corresponding put_device(). Thus add put_device() to fix the exception
> > handling.
> > 
> > Fixes: 15de8c6 ("mtd: rawnand: ingenic: Separate top-level and SoC specific code")
> > Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> > Reviewed-by: Paul Cercueil <paul@crapouillou.net>  
> 
> Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next, thanks.

Pushed on mtd/fixes, actually.
