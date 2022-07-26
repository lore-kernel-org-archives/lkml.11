Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0867CC00140
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jul 2022 19:33:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237717AbiGZTdI (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jul 2022 15:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiGZTdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 15:33:06 -0400
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1DCDD101CD
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 12:33:04 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 26QJWrwg016822;
        Tue, 26 Jul 2022 21:32:53 +0200
Date:   Tue, 26 Jul 2022 21:32:53 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: Re: Tag for upcoming nolibc pull request
Message-ID: <20220726193253.GA16812@1wt.eu>
References: <20220726184328.GA3404553@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220726184328.GA3404553@paulmck-ThinkPad-P17-Gen-1>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Paul,

On Tue, Jul 26, 2022 at 11:43:28AM -0700, Paul E. McKenney wrote:
> Hello!
> 
> I have pushed out a signed nolibc pull request tag "nolibc.2022.07.27a"
> on the -rcu tree, as shown below.
> 
> Please let me know if I should make changes to the tag's title or body.
> 
> If I don't hear otherwise by Friday morning (July 29th), Pacific Time,
> I will use this tag for my nolibc pull request to Linus.

That's pretty fine by me, thank you!

Willy
