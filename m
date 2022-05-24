Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3E2BC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 24 May 2022 17:24:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239841AbiEXRYk (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 May 2022 13:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234115AbiEXRYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 13:24:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 430E67CB55
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 10:24:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DF6336140D
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 17:24:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC463C34100;
        Tue, 24 May 2022 17:24:35 +0000 (UTC)
Date:   Tue, 24 May 2022 13:24:34 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Yuntao Wang <ytcoode@gmail.com>
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tracing: Deal with error return code of the
 ftrace_process_locs() function
Message-ID: <20220524132434.3cf03936@gandalf.local.home>
In-Reply-To: <20220120065949.1813231-1-ytcoode@gmail.com>
References: <20220119095741.1fff2305@gandalf.local.home>
        <20220120065949.1813231-1-ytcoode@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Jan 2022 06:59:49 +0000
Yuntao Wang <ytcoode@gmail.com> wrote:

> The ftrace_process_locs() function may return -ENOMEM error code, which
> should be handled by the callers.
> 
> Signed-off-by: Yuntao Wang <ytcoode@gmail.com>
> ---
> Changes since v1:
> - Deal with error return code instead of just removing it
> 
> 

Thanks, I added this to my queue. Note, I renamed the subject to start with
"ftrace:" instead of "tracing:" as this is specific to ftrace (the function
hook infrastructure).

-- Steve
