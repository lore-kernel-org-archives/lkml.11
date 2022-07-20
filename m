Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 452DBC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jul 2022 01:54:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241049AbiGTBy3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jul 2022 21:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235626AbiGTBy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 21:54:28 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34AF94D153;
        Tue, 19 Jul 2022 18:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=A7l+g/qWQ4kbR2s0S+aKFyjrf8X6RNK35iKShEyb7G0=; b=QncqZ02H7ZPqbcB+b44ViNYN72
        BNCeTDjyd2w3rQL71z3FOErj1ZOvJf+BjS4zonz6gJx0NTVdAieJArFtRPhGWrfKJZwHivUPef8rb
        lN3p0Wh7C5il1wwLZ7bWCY+YPAfy1CFPuNztmmKap4nu2Dz+48txcQBvXvo1tJRakBpBw26BLkoyU
        GUxcdur67bt4hfz9FAWi4S+fqjpu0HxYeItGkUjh/BuOGvUkqcXGrXky8IGaZGnUS4PvDM5f07Iqv
        Y4xqJs2Nqx+2NSt4f6LTnin94723mSeRLloYniSH7WUR8FP4hmy/CsJrZa6An4KKEt5FzS9R0SNrX
        61JQprnQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1oDyuu-00DwiQ-6X;
        Wed, 20 Jul 2022 01:54:24 +0000
Date:   Wed, 20 Jul 2022 02:54:24 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Ian Kent <raven@themaw.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] vfs: add propagate_mount_tree_busy() helper
Message-ID: <YtdgUOJlTc4aB+82@ZenIV>
References: <165751053430.210556.5634228273667507299.stgit@donald.themaw.net>
 <165751066658.210556.1326573473015621909.stgit@donald.themaw.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <165751066658.210556.1326573473015621909.stgit@donald.themaw.net>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 11, 2022 at 11:37:46AM +0800, Ian Kent wrote:

> +static int do_mount_in_use_check(struct mount *mnt, int cnt)
> +{
> +	struct mount *topper;
> +
> +	/* Is there exactly one mount on the child that covers
> +	 * it completely?
> +	 */
> +	topper = find_topper(mnt);
> +	if (topper) {
> +		int topper_cnt = topper->mnt_mounts_cnt + 1;
> +
> +		/* Open file or pwd within singular mount? */
> +		if (do_refcount_check(topper, topper_cnt))
> +			return 1;

Whatever the hell for?  umount(2) will be able to slide the
underlying mount from under the topper, whatever the
refcount of topper might have been.
