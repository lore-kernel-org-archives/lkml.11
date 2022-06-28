Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C19FC43334
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jun 2022 17:56:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232986AbiF1R4G (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jun 2022 13:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231903AbiF1R4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 13:56:04 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EBC5F28;
        Tue, 28 Jun 2022 10:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=lka0K/q1pqn7nJ349mPd6SEQ5BN4h62u2lSLrfIqDiU=; b=KYo5+sYiPYcYJnPvh4NepXYXFt
        VRGnlm3oQFSHSHXvAATBaXzV91Mv6GxjQ8KLWL6/21EfXXGG61iIBbyDn5winrh8Y5qu5kH4UGN1M
        X5KSoLZflyxW3cuoBQc3UlBT62hLIrNROBrdk5+sE1rzA4qzuAPAC21mZ+eqUgHupKOZXcULxNLm7
        qex4hmbQQpIr8blRE+MNRLDhiOo4Ef8ujaSmUG8dyZe0ruEDAIxGt582+Y9mQ9Lp2NIYsZBn5Hs46
        +qsAci2jr56SwhCrTJJ14ACWu/Ucw/njxSDDWmdHg701lu0LZ5wKjy/JN8cEQhVs2z9ctorWpwkG1
        eXQYIU1Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1o6FRJ-005hSj-6E;
        Tue, 28 Jun 2022 17:55:53 +0000
Date:   Tue, 28 Jun 2022 18:55:53 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Ian Kent <raven@themaw.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Siddhesh Poyarekar <siddhesh@gotplt.org>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Carlos Maiolino <cmaiolino@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] vfs: parse: deal with zero length string value
Message-ID: <YrtAqQoyFG/6Y4un@ZenIV>
References: <165637619182.37717.17755020386697900473.stgit@donald.themaw.net>
 <165637625215.37717.9592144816249092137.stgit@donald.themaw.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <165637625215.37717.9592144816249092137.stgit@donald.themaw.net>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2022 at 08:30:52AM +0800, Ian Kent wrote:
> Parsing an fs string that has zero length should result in the parameter
> being set to NULL so that downstream processing handles it correctly.
> For example, the proc mount table processing should print "(none)" in
> this case to preserve mount record field count, but if the value points
> to the NULL string this doesn't happen.

	Hmmm...  And what happens if you feed that to ->parse_param(), which
calls fs_parse(), which decides that param->key looks like a name of e.g.
u32 option and calls fs_param_is_u32() to see what's what?  OOPS is a form
of rejection, I suppose, but...
