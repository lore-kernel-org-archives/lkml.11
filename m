Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B09EC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Apr 2022 08:40:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235982AbiDYInq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Apr 2022 04:43:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238424AbiDYInI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 04:43:08 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8F567520A
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 01:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=cQDFKRoKhhktwi5lxO+7XU88CodqUGjLfy0fXQQbBls=; b=P1WwPXVBU/QFKHB9epGK/BAyJA
        mWNpBNQq/+z4WHeU+lvMqB2b68ckLMIIeN0sbOWCW41rjvmla0jv94+e0x/BWDMjzS11W+/QD+jqh
        moWslPyp6wMvFo4byFheoxzBt+myYSgbzsgdnLmpkjohTSS/Zgh2ySbNJ1xs9TbCzU9UW1lPTT92D
        sI34Y+tCGWMs2J4O/Vmpl7jdXIfElft7Bvfp5rO6xgR1wPCYXAW0COtouJR5zAuibRdl0YAGbrXBK
        4W2LSXN/fMNwzDrUwAJYcKK3h7HaqSItmre97lxw1id6moi66sxheru3x54MbebP2J5cSWm90EK8+
        irZ19lyA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1niuFi-008V9m-Rh; Mon, 25 Apr 2022 08:39:27 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 66CF3980BF1; Mon, 25 Apr 2022 10:39:26 +0200 (CEST)
Date:   Mon, 25 Apr 2022 10:39:26 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Donghai Qiao <dqiao@redhat.com>
Cc:     akpm@linux-foundation.org, sfr@canb.auug.org.au, arnd@arndb.de,
        heying24@huawei.com, andriy.shevchenko@linux.intel.com,
        axboe@kernel.dk, rdunlap@infradead.org, tglx@linutronix.de,
        gor@linux.ibm.com, donghai.w.qiao@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/11] smp: consolidate the structure definitions to
 smp.h
Message-ID: <20220425083926.GC2731@worktop.programming.kicks-ass.net>
References: <20220422200040.93813-1-dqiao@redhat.com>
 <20220422200040.93813-2-dqiao@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220422200040.93813-2-dqiao@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 22, 2022 at 04:00:30PM -0400, Donghai Qiao wrote:
> Move the structure definitions from kernel/smp.c to
> include/linux/smp.h
> 
> Move the structure definitions from include/linux/smp_types.h
> to include/linux/smp.h and delete smp_types.h

This Changelog is missing a *why*. Why are you exposing things that were
not exposed before..
