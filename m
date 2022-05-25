Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BF51C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 25 May 2022 16:35:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238370AbiEYQfN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 May 2022 12:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbiEYQfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 12:35:10 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FB0137A35
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 09:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jypLC8pMrKW0j3fSKUVuFFR8ZiBy4DELSKaBKyQvyj4=; b=tw9L7T0NXo7o8eoYtv9HAlFJ8p
        L8VesaUCmyf9j2hJlMwXCqIiF5knDSafP/unnkHP21GatUd0qAR62AtoOWDASqTt0krGn6MnufJbv
        3ljk4sYzaejG9Y1yM8wUn41A44E01dCZq9pGrc0iX6iAHHufGkpiJZlg0URKQ8FobzkPAXBHmSVfD
        rpgJM1utg7ZlWklOaPfUT3XlMJXkAqBkw1daFbYFgapTt71GfmBTTvpd9Ela7aXmIw0H2QC5Y2jxd
        QxdAR2p0qbnusQPE1FQ2q4lLabGdOAbwP1U6impkOxQ8fIaSzZblWlsgK/psyihsFaKsGMMtTuhE2
        RjMwFmJA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ntty4-000W0O-P8; Wed, 25 May 2022 16:34:40 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id CF351980E04; Wed, 25 May 2022 18:34:37 +0200 (CEST)
Date:   Wed, 25 May 2022 18:34:37 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, aik@ozlabs.ru,
        sv@linux.ibm.com, rostedt@goodmis.org, jpoimboe@redhat.com,
        naveen.n.rao@linux.vnet.ibm.com, mbenes@suse.cz,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH v1 1/4] Revert "objtool: Enable objtool to run only
 on files with ftrace enabled"
Message-ID: <20220525163437.GH2578@worktop.programming.kicks-ass.net>
References: <cover.1653494186.git.christophe.leroy@csgroup.eu>
 <262b4209a4a8fe99a97d23b89776380cbdad8b38.1653494186.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <262b4209a4a8fe99a97d23b89776380cbdad8b38.1653494186.git.christophe.leroy@csgroup.eu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 25, 2022 at 05:58:14PM +0200, Christophe Leroy wrote:
> This reverts commit cf3013dfad89ad5ac7d16d56dced72d7c138a20e.
> 
> That commit is problematic as we miss some static calls.

Revert ?!?! who comitted this. And there's a ton more broken than just
static calls. This must absolutely not be.
