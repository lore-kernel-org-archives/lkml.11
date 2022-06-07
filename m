Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BB5FC433EF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jun 2022 01:48:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233717AbiFHBsU convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jun 2022 21:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1447089AbiFGXGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 19:06:23 -0400
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66DAA1DE8C4
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 13:30:51 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 39C0361B8B4C;
        Tue,  7 Jun 2022 22:30:29 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id HT-WCvRXO0X0; Tue,  7 Jun 2022 22:30:28 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id AFAB261B8B68;
        Tue,  7 Jun 2022 22:30:28 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 13BXEJVUW9oh; Tue,  7 Jun 2022 22:30:28 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 8F1A061B8B4C;
        Tue,  7 Jun 2022 22:30:28 +0200 (CEST)
Date:   Tue, 7 Jun 2022 22:30:28 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     =?utf-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <kernel@kempniu.pl>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <75745632.147517.1654633828458.JavaMail.zimbra@nod.at>
In-Reply-To: <20220516070601.11428-3-kernel@kempniu.pl>
References: <20220516070601.11428-1-kernel@kempniu.pl> <20220516070601.11428-3-kernel@kempniu.pl>
Subject: Re: [PATCH 2/2] mtdchar: use kvmalloc() for potentially large
 allocations
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: mtdchar: use kvmalloc() for potentially large allocations
Thread-Index: GV6LOGkacTyBnlb9cH8NJV3ZRtoFFQ==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "Michał Kępień" <kernel@kempniu.pl>
> An: "Miquel Raynal" <miquel.raynal@bootlin.com>, "richard" <richard@nod.at>, "Vignesh Raghavendra" <vigneshr@ti.com>
> CC: "linux-mtd" <linux-mtd@lists.infradead.org>, "linux-kernel" <linux-kernel@vger.kernel.org>
> Gesendet: Montag, 16. Mai 2022 09:06:01
> Betreff: [PATCH 2/2] mtdchar: use kvmalloc() for potentially large allocations

> mtdchar_write_ioctl() calls kmalloc() with the 'size' argument set to
> the smaller of two values: the write request's data/OOB length provided
> by user space and the erase block size of the MTD device.  If the latter
> is large, kmalloc() may not be able to serve such allocation requests.
> Use kvmalloc() instead.  Correspondingly, replace kfree() calls with
> kvfree() calls.
> 
> Suggested-by: Richard Weinberger <richard@nod.at>
> Signed-off-by: Michał Kępień <kernel@kempniu.pl>

Looks good to me.
Acked-by: Richard Weinberger <richard@nod.at>

Thanks,
//richard
