Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CCD2C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Apr 2022 07:23:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232060AbiDYH0Q (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Apr 2022 03:26:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiDYH0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 03:26:09 -0400
Received: from gentwo.de (gentwo.de [161.97.139.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05301644C
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 00:23:03 -0700 (PDT)
Received: by gentwo.de (Postfix, from userid 1001)
        id 2A115B000C1; Mon, 25 Apr 2022 09:23:01 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.de (Postfix) with ESMTP id 27161B00078;
        Mon, 25 Apr 2022 09:23:01 +0200 (CEST)
Date:   Mon, 25 Apr 2022 09:23:01 +0200 (CEST)
From:   Christoph Lameter <cl@gentwo.de>
To:     Aaron Tomlin <atomlin@redhat.com>
cc:     frederic@kernel.org, mtosatti@redhat.com, tglx@linutronix.de,
        mingo@kernel.org, peterz@infradead.org, pauld@redhat.com,
        neelx@redhat.com, oleksandr@natalenko.name,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH v3] tick/sched: Ensure quiet_vmstat() is called when
 the idle tick was stopped too
In-Reply-To: <20220422193647.3808657-1-atomlin@redhat.com>
Message-ID: <alpine.DEB.2.22.394.2204250919400.2367@gentwo.de>
References: <20220422193647.3808657-1-atomlin@redhat.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Apr 2022, Aaron Tomlin wrote:

> A customer provided some evidence which indicates that the idle tick was
> stopped; albeit, CPU-specific vmstat counters still remained populated.
> Thus one can only assume quiet_vmstat() was not invoked on return to the
> idle loop.

Could we *always* fold the vmstat counters when entering idle mode? That
would make the logic less complicated. There is nothing else to do since
we are entering an idle state and if there are any counter deltas then we
have the time to process them. This may also decrease the time that
deltas exist significantly and an idle system will have accurate vmstat
counters.
