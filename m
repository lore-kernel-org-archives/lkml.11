Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3775C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 30 May 2022 23:04:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242677AbiE3XEN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 May 2022 19:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234303AbiE3XEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 19:04:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68CC853A43
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 16:04:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0294F60FA9
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 23:04:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44D62C385B8;
        Mon, 30 May 2022 23:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1653951850;
        bh=+UGtoxPlhwYJZG/Fb3M4NWWp3KEr2u92gtuPNKvQGl4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Bt8rnnr6VZikWr5d22PbZF60kJdfCrOWQl0RM3ZT9nEc+trY7uhQg00fLbzQVE+bl
         OcaN/qqZbqbcsXH7mV6RlqM2N1FeWIhuuYj05y87u7H/U9BlUZ3khR9lNoYd+cyyXx
         Kn0siaiFjV1zQ8uZbGWj2ZgBBwxA+2tsJr3EyNoA=
Date:   Mon, 30 May 2022 16:04:09 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] mm/swapfile: avoid confusing swap cache statistics
Message-Id: <20220530160409.c9b17085adb6112d8580f37d@linux-foundation.org>
In-Reply-To: <20220527092626.31883-3-linmiaohe@huawei.com>
References: <20220527092626.31883-1-linmiaohe@huawei.com>
        <20220527092626.31883-3-linmiaohe@huawei.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 May 2022 17:26:25 +0800 Miaohe Lin <linmiaohe@huawei.com> wrote:

> At swapoff time, we're going to swap in the pages continuously. So calling
> lookup_swap_cache would confuse statistics. We should use find_get_page
> directly here.

Why is the existing behaviour wrong?  swapoff() has to swap stuff in to
be able to release the swap device.  Why do you believe that this
swapin activity should not be accounted?


