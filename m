Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8002CC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Feb 2022 14:54:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355415AbiBNOys (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Feb 2022 09:54:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237244AbiBNOyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 09:54:44 -0500
X-Greylist: delayed 207 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 14 Feb 2022 06:54:36 PST
Received: from out1.migadu.com (out1.migadu.com [91.121.223.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F8421DA6A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 06:54:36 -0800 (PST)
Date:   Mon, 14 Feb 2022 23:54:30 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1644850475;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=At6z25KVyLmr+Oho1MeB6eHlhCEveeIWp0LPl89s+gQ=;
        b=O6k8/5IvJy1wUpyPOi8cOkBEdLXaRr3GBgdp/vu66g/ZC3/1KBvN4sbp9yuQ0Wcrkf2IW9
        02mP8STw/bKgzIWjFTmPwhGUVDRMPtnSXu3P836DEcUqhJdpeqHOs0HF2ULxNUtQbRGD2/
        dlgxX/xvH7XnSl9NFhuybSqw62lFyXg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Naoya Horiguchi <naoya.horiguchi@linux.dev>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, naoya.horiguchi@nec.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/8] mm/memory-failure.c: remove unnecessary
 PageTransTail check
Message-ID: <20220214145430.GG2624914@u2004>
References: <20220210141733.1908-1-linmiaohe@huawei.com>
 <20220210141733.1908-9-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220210141733.1908-9-linmiaohe@huawei.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 10, 2022 at 10:17:33PM +0800, Miaohe Lin wrote:
> When we reach here, we're guaranteed to have non-compound page as thp is
> already splited. Remove this unnecessary PageTransTail check.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Acked-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
