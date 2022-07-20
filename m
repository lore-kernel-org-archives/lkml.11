Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACE00C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jul 2022 07:07:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236465AbiGTHHT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jul 2022 03:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbiGTHHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 03:07:17 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAD013F30F;
        Wed, 20 Jul 2022 00:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2mwb27hXhlVj0Qf0BnrfNkp5B3QaOMmsisrg1fctKZU=; b=dg4T0cSj098fRX+DZKwxofwTM4
        DPRY9Do5KG7lgst1SyZOXL/27WrkxliA6nQYrRIjltzI3bYKS9kHkI6JjsMhWs9yq3WfGIDDFEPaA
        RzOJadwdayv2mlBy1UiVk8GBeayITTAELw6Ho0LUuRZepAu4Etp7QxrVQdc7KkzV9ael3439xV7be
        rG9NH+6/p5wzLWojxfdNeiPdt7pBmiru/WWBDPmFgiAHyD6IUJhPeasVJMOiqask81+n/0LqHCkzR
        3GbkrglV5cyRq4fDGlrh01HqRW4B8ayYPI8t8zsIsDjbJXteB4JztF3Dop6NfOvU3ijEOQ3cvHJB+
        Jrd37gxg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1oE3nX-00E11V-MC;
        Wed, 20 Jul 2022 07:07:07 +0000
Date:   Wed, 20 Jul 2022 08:07:07 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Helge Deller <deller@gmx.de>
Cc:     Hillf Danton <hdanton@sina.com>, linux-kernel@vger.kernel.org,
        linux-parisc@vger.kernel.org
Subject: Re: WARNING: CPU: 1 PID: 14735 at fs/dcache.c:365
 dentry_free+0x100/0x128
Message-ID: <YtepmwLj//zrD3V3@ZenIV>
References: <20220709090756.2384-1-hdanton@sina.com>
 <20220715133300.1297-1-hdanton@sina.com>
 <cff76e00-3561-4069-f5c7-26d3de4da3c4@gmx.de>
 <Ytd2g72cj0Aq1MBG@ZenIV>
 <860792bb-1fd6-66c6-ef31-4edd181e2954@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <860792bb-1fd6-66c6-ef31-4edd181e2954@gmx.de>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 20, 2022 at 08:53:53AM +0200, Helge Deller wrote:
> On 7/20/22 05:29, Al Viro wrote:
> > On Sat, Jul 16, 2022 at 07:27:30AM +0200, Helge Deller wrote:
> >> On 7/15/22 15:33, Hillf Danton wrote:
> >
> >> [108565.341434] dentry->d_u.d_rcu = 0x416be770
> >
> > Incidentally, does that match the address of __d_free() on your build,
> > or is it something different?
> 
> I don't think it's __d_free().
> The source is:
> 	pr_err("dentry->d_u.d_rcu = %pS\n", dentry->d_u.d_rcu.func);
> so the "%pS" would probably have resolved the pointer to string "__d_free" (or something else).

????

That should've taken a word from desc->addr and printed it.
If it had managed to get to a string (you'd needed to have
CONFIG_KALLSYMS enabled), it would've printed it as a string,
not as hex address.  Seriously, check System.map for that
kernel...
