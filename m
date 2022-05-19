Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3797FC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 19 May 2022 13:15:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238512AbiESNPT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 May 2022 09:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232830AbiESNPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 09:15:17 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1088FC5E6E
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 06:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1Qau8N189c6qQ1DvRBrKCoXkXc1SDys4onw+5HcpY5E=; b=fcDupoRAlyaVYJq+I47XWhkzlj
        6WSik0t0jWw6bEJbJ8K6IS8g+pPNRZfPo2b9CE5dH8ULDL9XeXn2X3tPp+9zJRWkQ+UG7xHz2OLlG
        eS8lksWeyKEULSEXCW0T8BNsyBhIl9EHRHZZydwa35qv8lXv8zUnR+8N8gAeMc7B/x47PraXHowS5
        KKh8zkxkGOGv+fZbEqNbzXI2WHm9Ip9xuIK8tp+UGFRzGzIBBHQXpBJyrX+w11iUv7X+QAjTvBaw3
        9pngOvaUDh2w/ptQUfGR3CC8Z//WWDiHBJ10a9Ygo09cBObNZEVeWEQE5+/nhq3lpLbD02+R5KYid
        qtrcc84Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nrfzT-00CkKT-0P; Thu, 19 May 2022 13:14:55 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8B351980E0B; Thu, 19 May 2022 15:14:52 +0200 (CEST)
Date:   Thu, 19 May 2022 15:14:52 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jing-Ting Wu <jing-ting.wu@mediatek.com>
Cc:     Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>, tglx@linutronix.de,
        wsd_upstream@mediatek.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, Jonathan.JMChen@mediatek.com,
        "chris.redpath@arm.com" <chris.redpath@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Vincent Donnefort <vdonnefort@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Christian Brauner <brauner@kernel.org>
Subject: Re: [Bug] Race condition between CPU hotplug off flow and
 __sched_setscheduler()
Message-ID: <20220519131452.GG2578@worktop.programming.kicks-ass.net>
References: <4a0aa13c99ffd6aea6426f83314aa2a91bc8933f.camel@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a0aa13c99ffd6aea6426f83314aa2a91bc8933f.camel@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 19, 2022 at 08:53:15PM +0800, Jing-Ting Wu wrote:
> Hi all
> 
> 
> There is a race condition between CPU hotplug off flow and
> __sched_setscheduler(), which will cause hang-up in CPU hotplug off
> flow.

Oooh, you're using core scheduling and the A/B are SMT siblings?
