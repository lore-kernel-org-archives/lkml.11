Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 319EEC433EF
	for <linux-kernel@archiver.kernel.org>; Fri,  6 May 2022 04:57:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389045AbiEFFAx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 May 2022 01:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235116AbiEFFAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 01:00:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EE9A41F9F;
        Thu,  5 May 2022 21:57:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 26F0861E64;
        Fri,  6 May 2022 04:57:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A953C385AA;
        Fri,  6 May 2022 04:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1651813027;
        bh=Mp3xXKksRLPT0VmSQGwBdzv3sQNGSGT21477IsjjvdM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oQdfG2fRwcOPTCfgEM2FPdWUEHQYTAopYSAiYQSztqX7tWZNTDHEfKMYoHAYWeyHB
         EbyuQM/ZS3A5I0LoVHvwpIFe0UikBpgNXejoqWSQocDDKPR7HavfuOQW6UGXrcUyKT
         ad2NvK2dzndkApK9ZYL52Z8Yk9+AtlEPWiCcK174=
Date:   Thu, 5 May 2022 21:57:06 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     CGEL <cgel.zte@gmail.com>
Cc:     david@redhat.com, kbuild-all@lists.01.org, corbet@lwn.net,
        bsingharora@gmail.com, mike.kravetz@oracle.com,
        yang.yang29@zte.com.cn, sfr@canb.auug.org.au,
        thomas.orgis@uni-hamburg.de, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] delayacct: track delays from write-protect copy
Message-Id: <20220505215706.dd5f27399d99ef53cfb9244c@linux-foundation.org>
In-Reply-To: <62748c65.1c69fb81.2aa2d.4a7b@mx.google.com>
References: <20220408103708.2495882-1-yang.yang29@zte.com.cn>
        <202204082220.1w5xTsNt-lkp@intel.com>
        <62748c65.1c69fb81.2aa2d.4a7b@mx.google.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 May 2022 02:48:04 +0000 CGEL <cgel.zte@gmail.com> wrote:

>     I found this patch is first merged into linux-next, and dropped silently
> without sending any mail. Could you please tell the reason? Thanks!

It's still in my tree, part of a small queue of post-linux-next patches
which I'm not presently distributing.  I'll bring it back soon.
