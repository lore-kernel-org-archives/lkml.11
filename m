Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B79FC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 25 May 2022 16:50:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245485AbiEYQul (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 May 2022 12:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244734AbiEYQuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 12:50:39 -0400
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3699B1145C
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 09:50:36 -0700 (PDT)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 24PGet78019132;
        Wed, 25 May 2022 11:40:55 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 24PGes7x019131;
        Wed, 25 May 2022 11:40:54 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Wed, 25 May 2022 11:40:54 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, peterz@infradead.org,
        aik@ozlabs.ru, sv@linux.ibm.com, rostedt@goodmis.org,
        jpoimboe@redhat.com, naveen.n.rao@linux.vnet.ibm.com,
        mbenes@suse.cz, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 2/4] objtool: Add R_REL32 macro
Message-ID: <20220525164054.GO25951@gate.crashing.org>
References: <cover.1653494186.git.christophe.leroy@csgroup.eu> <35932b18ea948cbc1e7ec9d006e4575641a4daa5.1653494186.git.christophe.leroy@csgroup.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35932b18ea948cbc1e7ec9d006e4575641a4daa5.1653494186.git.christophe.leroy@csgroup.eu>
User-Agent: Mutt/1.4.2.3i
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Wed, May 25, 2022 at 05:58:15PM +0200, Christophe Leroy wrote:
> In order to allow other architectures than x86 to use 32 bits
> relative relocations, define a R_REL32 macro that each architecture
> will define, in the same way as already done for R_NONE.

What are the expected semantics of this relocation?  It is PC-relative,
sure, but what is the destination?  S+A-P always?  That works for both
x86-64 and for PowerPC, but it should be written doen somewhere :-)


Segher
