Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70AEFC433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Apr 2022 18:10:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345617AbiDOSMq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Apr 2022 14:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbiDOSMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 14:12:41 -0400
X-Greylist: delayed 159 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 15 Apr 2022 11:10:11 PDT
Received: from pi3.com.pl (pi3.com.pl [185.238.74.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DC094EF69
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 11:10:10 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by pi3.com.pl (Postfix) with ESMTP id 782CF4C15D0;
        Fri, 15 Apr 2022 20:10:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=pi3.com.pl; s=default;
        t=1650046209; bh=vzriO2rukXRgX+LeFsQqW4sLbXnUJn11h/2sdhPYil8=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=ep/SBcmCQEu1xs5fptQXWG3I8hXdfsAc4KelRwSr1on+8a/VeeIYKC3GX4Kju0Kh6
         wtQttTEvP6Yp7LCVq1qm0fRDYq7vcfdPpzwxWoKuFKPMDuqg6tKOxJjr93MpGyIuyO
         1pDOfpdCEAKPAdiewbMLMkQzGLGwlfEMKFTFcSfkcU7iGZfGLT7lCsLNyWNWjCaDHq
         EQzsn7Sofn+NZiAnkt/SkdwbN54XXy3IHLHRq1x2NJC6Es+q/fyt0WkZ78Z6vuDSM9
         ivs+boW9K7gFQ353Wmb/AUzSbrpKnv3eU6hPUHY8MMGs/c6tHcaCdE9Wl4mROaCbHa
         erA5MY2gX4yPg==
X-Virus-Scanned: Debian amavisd-new at pi3.com.pl
Received: from pi3.com.pl ([127.0.0.1])
        by localhost (pi3.com.pl [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id yTX2jt2Pj4FN; Fri, 15 Apr 2022 20:10:06 +0200 (CEST)
Received: by pi3.com.pl (Postfix, from userid 1000)
        id 655DA4C15D1; Fri, 15 Apr 2022 20:10:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=pi3.com.pl; s=default;
        t=1650046206; bh=vzriO2rukXRgX+LeFsQqW4sLbXnUJn11h/2sdhPYil8=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=Q8MKGo6PYl5zA9pVygaP6daC8VJIeV1Xx8Agb92no0ip7ZIyr4/7i7T/u+j4Ij0/B
         IcJU748i1gUa1+h+dGv27CJzfKRz9cWXjKI4etjwbm9DImGtfmkln4aj8s7pdic4vb
         FgvIUoP8G9Q2xB4Rr8eRzEBu4WmgD7PkiUSccHCQYDYIzkN0q7T8zVhnUpJlcZ2EGe
         yk7SxsibA8qeVH17b14iePgYP2sLE8lp492/uKqtBRXPCN9Or4ffNP0aFQ4FTWeAUv
         caszuHDM4yDG1RoiK5wDTviAxXzCUL0Yu+fhJJPzlHh67oSO3A3D/rV6Mki8vqJD0w
         Yz3pm7lqeblTA==
Date:   Fri, 15 Apr 2022 20:10:06 +0200
From:   Adam Zabrocki <pi3@pi3.com.pl>
To:     "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, Solar Designer <solar@openwall.com>
Subject: [PATCH] x86/kprobes: Fix KRETPROBES when CONFIG_KRETPROBE_ON_RETHOOK
 is set
Message-ID: <20220415181006.GA14021@pi3.com.pl>
References: <20220415180723.GA13921@pi3.com.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220415180723.GA13921@pi3.com.pl>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] x86/kprobes: Fix KRETPROBES when CONFIG_KRETPROBE_ON_RETHOOK is set

The recent kernel change "kprobes: Use rethook for kretprobe if possible",
introduced a potential NULL pointer dereference bug in the KRETPROBE
mechanism. The official Kprobes documentation defines that "Any or all
handlers can be NULL". Unfortunately, there is a missing return handler
verification to fulfill these requirements and can result in a NULL pointer
dereference bug.

This patch adds such verification in kretprobe_rethook_handler() function.

Fixes: 73f9b911faa7 ("kprobes: Use rethook for kretprobe if possible")
Signed-off-by: Adam Zabrocki <pi3@pi3.com.pl>
---
 kernel/kprobes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index dbe57df2e199..dd58c0be9ce2 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -2126,7 +2126,7 @@ static void kretprobe_rethook_handler(struct rethook_node *rh, void *data,
 	struct kprobe_ctlblk *kcb;
 
 	/* The data must NOT be null. This means rethook data structure is broken. */
-	if (WARN_ON_ONCE(!data))
+	if (WARN_ON_ONCE(!data) || !rp->handler)
 		return;
 
 	__this_cpu_write(current_kprobe, &rp->kp);

-- 
pi3 (pi3ki31ny) - pi3 (at) itsec pl
http://pi3.com.pl

