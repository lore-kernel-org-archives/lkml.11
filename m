Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8482FC43334
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jun 2022 16:47:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356190AbiFAQrs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jun 2022 12:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234144AbiFAQrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 12:47:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCCCB3FD87
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 09:47:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 80F74615CD
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 16:47:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A89E3C385B8;
        Wed,  1 Jun 2022 16:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654102064;
        bh=vpX+RchnCKz170MMQrXhkUd9iB/TXy1f+YQjMDZwgTk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PhY5EzHoJ0KfBn2VvyiOVzx+ZW1pKwqL8rBcVmx/fpg0zp2nW4tLPlIj2WYgnoXt4
         h1rqNt0Es4jM9HAGxW+hHPpGYxdWi/Pcr5W3r1diGVw+ocTIlhXF0ixpyKKQVobZ5H
         WsV9m+5cpmcGeSofMnsbGwLrYZwKsbSTvS2X1WF+LayX59bJBtrujx8R63PcTNJV6o
         MaMFvrp5a2rtlWavXLiLxhdwCB3rWt91PWvWB54LhGvJj/GkWTTXstGgA2MEnDNkQD
         NrzkeRp/2taBDlCMyk/JMCfHjmm9Ksrj7Vb0id+XMK4NPgN/+8gFaLzSL+DXLx/Gcl
         wfBZB+qakJFGA==
Date:   Wed, 1 Jun 2022 09:47:41 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] x86/ftrace: Fix objtool vmlinux.o __fentry__ warning
Message-ID: <20220601164741.r547yrz4p6jea6ih@treble>
References: <ffbae3ed9384307a0f867a366ca9b5765355f4dd.1654101038.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ffbae3ed9384307a0f867a366ca9b5765355f4dd.1654101038.git.jpoimboe@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 01, 2022 at 09:30:53AM -0700, Josh Poimboeuf wrote:
> The 'save_mcount_regs' macro does funny things with the frame pointer,
> which objtool doesn't approve of.  So OBJECT_FILES_NON_STANDARD is used
> with CONFIG_FRAME_POINTER to tell objtool to skip the entire file when
> frame pointers are enabled.
> 
> However, the file-wide OBJECT_FILES_NON_STANDARD annotation is now
> deprecated, because it doesn't work for IBT, where objtool runs on
> vmlinux.o.  Use more fine-grained function-specific annotations
> instead.
> 
> Fixes the following warning:
> 
>   vmlinux.o: warning: objtool: __fentry__+0x16: return with modified stack frame
> 
> Fixes: ed53a0d97192 ("x86/alternative: Use .ibt_endbr_seal to seal indirect calls")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>

NACK - I just found another robot warning for this one.

-- 
Josh
