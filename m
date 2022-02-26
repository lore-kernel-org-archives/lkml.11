Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B7BFC433EF
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Feb 2022 00:30:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234434AbiBZAae (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Feb 2022 19:30:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiBZAac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 19:30:32 -0500
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA0C0517C8
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 16:29:57 -0800 (PST)
Received: (Authenticated sender: joao@overdrivepizza.com)
        by mail.gandi.net (Postfix) with ESMTPA id 0B58720003;
        Sat, 26 Feb 2022 00:29:49 +0000 (UTC)
MIME-Version: 1.0
Date:   Fri, 25 Feb 2022 16:29:49 -0800
From:   Joao Moreira <joao@overdrivepizza.com>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        hjl.tools@gmail.com, jpoimboe@redhat.com,
        andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org,
        ndesaulniers@google.com, samitolvanen@google.com,
        mark.rutland@arm.com, alyssa.milburn@intel.com, mbenes@suse.cz,
        rostedt@goodmis.org, mhiramat@kernel.org,
        alexei.starovoitov@gmail.com, llvm@lists.linux.dev
Subject: Re: [PATCH v2 05/39] x86: Base IBT bits
In-Reply-To: <YhlTRhh7qj538ygM@dev-arch.archlinux-ax161>
References: <20220224145138.952963315@infradead.org>
 <20220224151322.307406918@infradead.org> <202202241627.EEF3D5D2@keescook>
 <YhgnA8O4Bp19hfse@dev-arch.archlinux-ax161>
 <YhlTRhh7qj538ygM@dev-arch.archlinux-ax161>
Message-ID: <605731324a76f36aafa87bd9390808c3@overdrivepizza.com>
X-Sender: joao@overdrivepizza.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> https://github.com/ClangBuiltLinux/linux/issues/1606

Candidate fix: https://reviews.llvm.org/D120600
