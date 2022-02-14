Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 426E5C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Feb 2022 14:48:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355356AbiBNOtD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Feb 2022 09:49:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239562AbiBNOtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 09:49:01 -0500
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C181C18
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 06:48:53 -0800 (PST)
Date:   Mon, 14 Feb 2022 23:48:46 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1644850131;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lLwJ5430NUBisC9DH+t5mWtgpmK2w+2aPFoyikZt3SE=;
        b=kTK53qmensoLWeNEhSHLAofif4JOHG6m2q1KYwdDxUGlLMFpd1pxPhSPUZaHMXo9TFLK8e
        KEjNQXIZ96Jirau3P8Lgd83npnfKzMetm1AIKTtjafeJtwP+JPo97I2E0iaTVKvGPe8cJI
        b/hh0AXMt3lNA/tTO5OafKrJ6Da1Tk0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Naoya Horiguchi <naoya.horiguchi@linux.dev>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, naoya.horiguchi@nec.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/8] mm/memory-failure.c: rework the signaling logic in
 kill_proc
Message-ID: <20220214144846.GC2624914@u2004>
References: <20220210141733.1908-1-linmiaohe@huawei.com>
 <20220210141733.1908-4-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220210141733.1908-4-linmiaohe@huawei.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 10, 2022 at 10:17:28PM +0800, Miaohe Lin wrote:
> BUS_MCEERR_AR code is only sent when MF_ACTION_REQUIRED is set and the
> target is current. Rework the code to make this clear.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Acked-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
