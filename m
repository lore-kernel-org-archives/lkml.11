Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A75DCC00140
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jul 2022 20:27:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239928AbiGZU1v (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jul 2022 16:27:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbiGZU1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 16:27:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D2BB275F5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 13:27:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 44241B8191D
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 20:27:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05400C433C1;
        Tue, 26 Jul 2022 20:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658867266;
        bh=X0x8Q9RYSizXN/S18SdvkUlZu5o1KaQIPwSnC4CkstE=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Dkj84ZzZ5euW+19mFAVLaloP5XPplMgeB678UpJMnmQ+oRBTM63ylbX3qn7pSwSCc
         rkygtiH0NocEbeY6eh+U25m+Y9BaDMgKPR7IAn12GNZHUiieqPzgTqQJJQIHdKpR0V
         P46jaXYWCExl5BU1aao6CBCUEjSvyKqabicU9YXQgWZzftZN2hMMp6HpDJx+pbO1Om
         AmlQflrfqu0ycqCZld/qKXgnWlgtb9p9Ph/iVLS1nTw2BYBc9wFPDR6o8CCkrSweDQ
         1lF4gyhccqINAVoJetWXavsReMxkNOzUuSkImD4fRIrRCGq7Tyv9TafMVNv/s3JR/7
         l2gaKJCp4V43A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 97BC95C0AEB; Tue, 26 Jul 2022 13:27:45 -0700 (PDT)
Date:   Tue, 26 Jul 2022 13:27:45 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: Re: Tag for upcoming nolibc pull request
Message-ID: <20220726202745.GJ2860372@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220726184328.GA3404553@paulmck-ThinkPad-P17-Gen-1>
 <20220726193253.GA16812@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220726193253.GA16812@1wt.eu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 26, 2022 at 09:32:53PM +0200, Willy Tarreau wrote:
> Hello Paul,
> 
> On Tue, Jul 26, 2022 at 11:43:28AM -0700, Paul E. McKenney wrote:
> > Hello!
> > 
> > I have pushed out a signed nolibc pull request tag "nolibc.2022.07.27a"
> > on the -rcu tree, as shown below.
> > 
> > Please let me know if I should make changes to the tag's title or body.
> > 
> > If I don't hear otherwise by Friday morning (July 29th), Pacific Time,
> > I will use this tag for my nolibc pull request to Linus.
> 
> That's pretty fine by me, thank you!

Very good, and thank you for checking it!

							Thanx, Paul
