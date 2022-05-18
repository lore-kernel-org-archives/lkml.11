Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EBBCC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 18 May 2022 14:45:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238835AbiEROpD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 May 2022 10:45:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238758AbiEROo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 10:44:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A2D71D4A34;
        Wed, 18 May 2022 07:44:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 177EBB820EA;
        Wed, 18 May 2022 14:44:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82A20C385A9;
        Wed, 18 May 2022 14:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652885094;
        bh=sLZDBfRImQRmLZ+nI1Q+0xE86Tid3u1WRmhso6KIs04=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XDVphIpl9/QBp0ieNsVrXN9pM0JBXP1+a6fSIa9IwYiK1Ue9nFlFhrp4aYR/MZGx5
         TN+XaMT+fkSOa7UEkWRsAZpnUVek0git3Bx9usHdDRfZ4+mi6vajkKc/MupbS0rGBX
         pnOvucmaRLfYukQuIxS6zIBbdjKisKhZx/g476y3sd8FnBajmZFkyu6X1W9vW+6lJh
         WB7M7M8woupFPRjtK8mOPQ5Jlq5a5WfmY+SyU4ewKJ5CYlcxU5VLYz1vCxk4rLEjV/
         R3eYhf8+QiewXAZQ9Biwc/GLQONfp05Sl1kDkkMcSjgae1EQZOq8IVxPWwmfiZ3SVH
         AHGzbZUe3x0HQ==
Date:   Wed, 18 May 2022 16:44:49 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Vasily Averin <vvs@openvz.org>
Cc:     Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        kernel@openvz.org, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Amir Goldstein <amir73il@gmail.com>,
        Matthew Bobrowski <repnop@google.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] sparse: fix incorrect fmode_t casts
Message-ID: <20220518144449.2oa464wnx4p6ovom@wittgenstein>
References: <YoNDA0SOFjyoFlJS@infradead.org>
 <86e82d40-0952-e76f-aac5-53abe48ec770@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <86e82d40-0952-e76f-aac5-53abe48ec770@openvz.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2022 at 01:49:07PM +0300, Vasily Averin wrote:
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

Looks good to me,
Reviewed-by: Christian Brauner (Microsoft) <brauner@kernel.org>
