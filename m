Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E767CC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 16 May 2022 11:47:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237765AbiEPLrU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 May 2022 07:47:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236114AbiEPLrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 07:47:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1961831B;
        Mon, 16 May 2022 04:47:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A5ECD61015;
        Mon, 16 May 2022 11:47:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0825AC385B8;
        Mon, 16 May 2022 11:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652701634;
        bh=A23pfhdPVoKFYVSK02SQZTwQCJVPjr8lpcsjffIrKuQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kDBPpVAWItdh/Fj5ceigYM4amRcZ3gblDQYFBDYY1oqEVbonkr5cef+Ihvaw4nmxh
         +o7KhGEeVCOO4ONJ3294fkrj7DB6d8deLz+noH4q81taDe1GZRbp9ReW0dYflP5dr1
         mI6fFepkysVs7GLnA0v3pfAncPsPDxHByjRsbCrrLmpIQ4NWn1haii4XM2/TjgsAZk
         kiKxVan3RRaf0onDz3n0W2VFXdJBk+/iYQIlk7zMhp5LIxlvJ2M225Ac+jLVfkuRf9
         SbxLhyvyDoE0ciBAjSApkqrObDFJMHNNC+X7mG2AgebMVg6uG//GI1hkZ4zqnEe4Eu
         qViZojmOqGjgg==
Date:   Mon, 16 May 2022 13:47:08 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Vasily Averin <vvs@openvz.org>
Cc:     Jan Kara <jack@suse.cz>, Alexander Viro <viro@zeniv.linux.org.uk>,
        kernel@openvz.org, linux-kernel@vger.kernel.org,
        Amir Goldstein <amir73il@gmail.com>,
        Matthew Bobrowski <repnop@google.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] sparse: use force attribute for fmode_t casts
Message-ID: <20220516114708.liw6sltketcahpkl@wittgenstein>
References: <1eb3b298-4f7e-32ad-74ae-12044ed637ed@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1eb3b298-4f7e-32ad-74ae-12044ed637ed@openvz.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 14, 2022 at 01:22:28PM +0300, Vasily Averin wrote:
> Fixes sparce warnings:
> fs/notify/fanotify/fanotify_user.c:267:63: sparse:
>  warning: restricted fmode_t degrades to integer
> fs/notify/fanotify/fanotify_user.c:1351:28: sparse:
>  warning: restricted fmode_t degrades to integer
> fs/proc/base.c:2240:25: sparse: warning: cast to restricted fmode_t
> fs/proc/base.c:2297:42: sparse: warning: cast from restricted fmode_t
> fs/proc/base.c:2394:48: sparse: warning: cast from restricted fmode_t
> fs/open.c:1024:21: sparse: warning: restricted fmode_t degrades to integer
> 
> Signed-off-by: Vasily Averin <vvs@openvz.org>
> ---
>  fs/notify/fanotify/fanotify_user.c | 4 ++--
>  fs/open.c                          | 2 +-

Looks good to me,
Reviewed-by: Christian Brauner (Microsoft) <brauner@kernel.org>
