Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92969C433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Apr 2022 03:25:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237075AbiDID1b (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Apr 2022 23:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiDID1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 23:27:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D2BD16C0B6
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 20:25:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B405C62298
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 03:25:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED296C385A4;
        Sat,  9 Apr 2022 03:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1649474717;
        bh=QztxxwJbpCCCWMERmgAVm2Swrx1fqBXopvd4ffA8cw8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=xOlvG7rB7RRzvIkCUU5vTfg+1GYBSbt9aLhxymSUz6j82IvAUZyhUMvzaGHaHWrai
         /30zp4sk0EJuLzTcNx1jeTyIQkrta0X3p3JUMHXmbqkzlICaKfXwDXA9ys7ce2rx0R
         21w+T41QYox5acwiAGfZVpGfZiqcvn5HzUaTHR6g=
Date:   Fri, 8 Apr 2022 20:25:16 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v9 0/4] mm: Enable conversion of powerpc to default
 topdown mmap layout
Message-Id: <20220408202516.254e22a8293a57324650bd3f@linux-foundation.org>
In-Reply-To: <cover.1649401201.git.christophe.leroy@csgroup.eu>
References: <cover.1649401201.git.christophe.leroy@csgroup.eu>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  8 Apr 2022 09:24:58 +0200 Christophe Leroy <christophe.leroy@csgroup.eu> wrote:

> Rebased on top of Linux 5.18-rc1
> 
> This is the mm part of the series that converts powerpc to default
> topdown mmap layout, for merge into v5.18

We're at 5.18-rc1.  The 5.18 merge window has closed and we're in
fixes-only mode.

If there's a case to be made that these patches are needed by 5.18
users then please let's make that case.  Otherwise, this is 5.19-rc1 material.

And if it is indeed all 5.19-rc1 material, then please carry all four
in the powerpc tree with Acked-by: Andrew Morton
<akpm@linux-foundation.org>.

Also, [4/4] has a cc:stable.  This is a bit odd because -stable
candidates should be standalone patches, staged ahead of all
for-next-merge-window material, so we can get them merged up quickly.

More oddly, [4/4]'s changelog provides no explanation for why the patch
should be considered for backporting.

