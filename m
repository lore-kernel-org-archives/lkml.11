Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20E2CC433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Feb 2022 19:36:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386148AbiBHTgt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Feb 2022 14:36:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350381AbiBHTgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 14:36:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C74FC0613CB
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 11:36:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 574A1B81D44
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 19:36:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D03B0C004E1;
        Tue,  8 Feb 2022 19:36:42 +0000 (UTC)
Date:   Tue, 8 Feb 2022 14:36:41 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Byungchul Park <byungchul.park@lge.com>,
        "Paul E. McKenney" <paul.mckenney@linaro.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Radoslaw Burny <rburny@google.com>
Subject: Re: [PATCH 03/12] timer: Protect lockdep functions with #ifdef
Message-ID: <20220208143641.7850bbc6@gandalf.local.home>
In-Reply-To: <20220208184208.79303-4-namhyung@kernel.org>
References: <20220208184208.79303-1-namhyung@kernel.org>
        <20220208184208.79303-4-namhyung@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  8 Feb 2022 10:41:59 -0800
Namhyung Kim <namhyung@kernel.org> wrote:

> With upcoming lock tracepoints config, it'd define some of lockdep
> functions without enabling CONFIG_LOCKDEP actually.  The existing code
> assumes those functions will be removed by the preprocessor but it's
> not the case anymore.  Let's protect the code with #ifdef's explicitly.

I wonder if it would be cleaner to have another macro name for these
locations to keep out the ugly #ifdef in the code.

lockdep_init_map_raw() ?

-- Steve


> 
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
