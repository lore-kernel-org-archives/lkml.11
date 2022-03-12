Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ED6BC433EF
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Mar 2022 21:27:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232736AbiCLV27 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Mar 2022 16:28:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbiCLV2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 16:28:54 -0500
Received: from relay5.hostedemail.com (relay5.hostedemail.com [64.99.140.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCAC76161
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 13:27:46 -0800 (PST)
Received: from omf14.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay07.hostedemail.com (Postfix) with ESMTP id 1D73920F38;
        Sat, 12 Mar 2022 21:27:45 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf14.hostedemail.com (Postfix) with ESMTPA id 2A62433;
        Sat, 12 Mar 2022 21:27:38 +0000 (UTC)
Message-ID: <19a139d0dde6fadfce79c10d40c9810b50702fb1.camel@perches.com>
Subject: Re: [PATCH]  staging: android: ashmem: Declared file operation with
 const keyword Warning found by checkpatch.pl script.
From:   Joe Perches <joe@perches.com>
To:     shaikh kamal <shaikhkamal2012@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arve =?ISO-8859-1?Q?Hj=F8nnev=E5g?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <brauner@kernel.org>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Date:   Sat, 12 Mar 2022 13:27:37 -0800
In-Reply-To: <20220312204128.3942-1-shaikhkamal2012@gmail.com>
References: <20220312204128.3942-1-shaikhkamal2012@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Stat-Signature: rtm1zbfs7dogbjaq5k5daswbtt1e356n
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 2A62433
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+se1DJYpmi2MVwrgiCDdqWbmGhMkicYQY=
X-HE-Tag: 1647120458-668950
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2022-03-13 at 03:11 +0530, shaikh kamal wrote:
[]
> diff --git a/drivers/staging/android/ashmem.c b/drivers/staging/android/ashmem.c
[]
> @@ -377,7 +377,7 @@ ashmem_vmfile_get_unmapped_area(struct file *file, unsigned long addr,
>  
>  static int ashmem_mmap(struct file *file, struct vm_area_struct *vma)
>  {
> -	static struct file_operations vmfile_fops;
> +	static const struct file_operations vmfile_fops;

Make sure to compile any files modified by your suggested patches
_before_ sending the patches.


