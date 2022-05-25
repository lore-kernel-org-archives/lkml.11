Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2CD7C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 25 May 2022 16:53:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245503AbiEYQxK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 May 2022 12:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237563AbiEYQxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 12:53:06 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34CA95E753
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 09:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HWanoelDjviMS4e2qR1g8RYJjbLW/SUdT8BkgC3E7RA=; b=EY4iQ2yDvjaPJSoZzgXq8I17Ly
        WrQ1Ua0+bPN+wJmkXJsJ8fPjuUrDzztRiN3kPCdPQyySWAHMv+TU1OvSFK1qndgcJ30G/9ErUVVw/
        hGcMQw0+Jhb9di/U7FuaUuucLzdkzRRVduAkS92T0hrvlrEng/H0hDHwA0G2o4Ja5yD185RwPm800
        bxdYM3mrR2BVPAvet5KwXB72zCYjp5twJhYhF6LsOjGsM2v/3kOBcQmIuR3FKFGOk9M8Pdjx605Kj
        fd/k2nYDAWCIYYRtki6UJR481dLLA2wXeGMiipqWrQG3XN3Z5lT/6N2C+LF37Icdn9jQ/0e2rFD27
        kWi75Dqw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ntuFg-001fij-Cl; Wed, 25 May 2022 16:52:53 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1C587980E04; Wed, 25 May 2022 18:52:48 +0200 (CEST)
Date:   Wed, 25 May 2022 18:52:48 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Donnefort <vdonnefort@google.com>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        vschneid@redhat.com, kernel-team@android.com,
        Derek Dolney <z23@posteo.net>
Subject: Re: [PATCH v2] cpu/hotplug: Do not bail-out in DYING/STARTING
 sections
Message-ID: <20220525165248.GI2578@worktop.programming.kicks-ass.net>
References: <20220523160536.2889162-1-vdonnefort@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220523160536.2889162-1-vdonnefort@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 23, 2022 at 05:05:36PM +0100, Vincent Donnefort wrote:
> The DYING/STARTING callbacks are not expected to fail. However, as reported
> by Derek, drivers such as tboot are still free to return errors within
> those sections. In that case, there's nothing the hotplug machinery can do,
> so let's just proceed and log the failures.
> 

I'm confused. Why isn't this a driver bug?
