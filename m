Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55971C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Apr 2022 13:16:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350354AbiDDNSa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Apr 2022 09:18:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231190AbiDDNS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 09:18:27 -0400
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2BAF33CA78;
        Mon,  4 Apr 2022 06:16:29 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 234DGMql009286;
        Mon, 4 Apr 2022 15:16:22 +0200
Date:   Mon, 4 Apr 2022 15:16:22 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Jan Kara <jack@suse.cz>
Cc:     Pavel Machek <pavel@ucw.cz>, Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        reiserfs-devel@vger.kernel.org
Subject: Re: Is it time to remove reiserfs?
Message-ID: <20220404131622.GC8279@1wt.eu>
References: <YhIwUEpymVzmytdp@casper.infradead.org>
 <20220222100408.cyrdjsv5eun5pzij@quack3.lan>
 <20220402105454.GA16346@amd>
 <20220404085535.g2qr4s7itfunlrqb@quack3.lan>
 <20220404100732.GB1476@duo.ucw.cz>
 <20220404101802.GB8279@1wt.eu>
 <20220404125541.tvcf3dwyfvxsnurz@quack3.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220404125541.tvcf3dwyfvxsnurz@quack3.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 04, 2022 at 02:55:41PM +0200, Jan Kara wrote:
> Yes, we start with a warning now. Say a year before we really do remove it,
> my plan is to refuse to mount it unless you pass a "I really know what I'm
> doing" mount option so that we make sure people who possibly missed a
> warning until that moment are aware of the deprecation and still have an
> easy path and some time to migrate.

That's a good idea. I was thinking as well about something manual (e.g.
manually modprobe the FS) but an option will be even better.

Willy
