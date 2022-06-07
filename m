Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C8F8CCA47C
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jun 2022 02:07:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443823AbiFHCGk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jun 2022 22:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1588068AbiFGXyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 19:54:04 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5019F6EC6E
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 15:55:54 -0700 (PDT)
Date:   Wed, 8 Jun 2022 00:55:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1654642548;
        bh=GKmspcdBAWIOqR/3BljCxm3zwnJIjgIflR7y21vWpks=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CgIjeww94QAkYJqcJd8V0NONcKTg2eSKdj8Km8wlj2XIm3HhwZjhvGB6Jhs0wrTlT
         kx1VGh9lfaALmdiDdJkxxy35Mc0R7bMjwYNGNCJ725ll1UqXG37I+0Zm7XeKzvWOgX
         ZveuXD2IozmQoV5qSTGebeKEIDxXFp0VeJh/5kxg=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: add device name to warning in uuid_show()
Message-ID: <169e1083-3d0a-42e0-a600-c41b275623ee@t-8ch.de>
References: <20220607155555.8623-1-linux@weissschuh.net>
 <Yp94yTFrrkbBYqsj@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Yp94yTFrrkbBYqsj@kbusch-mbp.dhcp.thefacebook.com>
Jabber-ID: thomas@t-8ch.de
X-Accept: text/plain, text/html;q=0.2, text/*;q=0.1
X-Accept-Language: en-us, en;q=0.8, de-de;q=0.7, de;q=0.6
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-06-07 10:11-0600, Keith Busch wrote:
> On Tue, Jun 07, 2022 at 05:55:55PM +0200, Thomas Weißschuh wrote:
> >  	if (uuid_is_null(&ids->uuid)) {
> > -		printk_ratelimited(KERN_WARNING
> > -				   "No UUID available providing old NGUID\n");
> > +		dev_warn_ratelimited(dev, "No UUID available providing old NGUID\n");
> >  		return sysfs_emit(buf, "%pU\n", ids->nguid);
> 
> The line split was correct to prevent this overly long line. But otherwise,
> this looks good, though I'm wondering why this needs to be printed every time
> someone reads the attribute.

Sorry about the long line, thought it looks nicer on one line and other
(similar) lines in the file are also using up to 100 characters per line.
Do you want me to resend it?

No idea why has to be printed every time. A dev_warn_once() would be less
spammy.
