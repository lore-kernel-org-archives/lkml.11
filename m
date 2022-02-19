Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 826BEC433F5
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Feb 2022 05:58:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240615AbiBSF6d (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Feb 2022 00:58:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232729AbiBSF6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 00:58:32 -0500
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C7DB4DF6B;
        Fri, 18 Feb 2022 21:58:14 -0800 (PST)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nLIl3-002v0S-54; Sat, 19 Feb 2022 05:58:13 +0000
Date:   Sat, 19 Feb 2022 05:58:13 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Rik van Riel <riel@surriel.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        linux-fsdevel@vger.kernel.org, paulmck@kernel.org,
        gscrivan@redhat.com, Eric Biederman <ebiederm@xmission.com>,
        Chris Mason <clm@fb.com>
Subject: Re: [PATCH 1/2] vfs: free vfsmount through rcu work from kern_unmount
Message-ID: <YhCG9cdw2JZSKbDZ@zeniv-ca.linux.org.uk>
References: <20220218183114.2867528-1-riel@surriel.com>
 <20220218183114.2867528-2-riel@surriel.com>
 <YhCF4Xre/iyyOgT5@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YhCF4Xre/iyyOgT5@zeniv-ca.linux.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 19, 2022 at 05:53:37AM +0000, Al Viro wrote:
> On Fri, Feb 18, 2022 at 01:31:13PM -0500, Rik van Riel wrote:
> 
> >  struct super_block;
> >  struct vfsmount;
> > @@ -73,6 +74,7 @@ struct vfsmount {
> >  	struct super_block *mnt_sb;	/* pointer to superblock */
> >  	int mnt_flags;
> >  	struct user_namespace *mnt_userns;
> > +	struct rcu_work free_rwork;
> >  } __randomize_layout;
> 
> Wait, what?  First of all, that has no business being in vfsmount -
> everything that deeply internal belongs in struct mount, not in
> its public part.  Moreover, there's already mount->mnt_rcu, so what's
> the point duplicating that?

Argh... You need rcu_work there...

OK, so make that a member of the same union mnt_rcu is.  In struct mount,
please.  And I'm not sure I like the idea of shoving that much into
struct mount, TBH...
