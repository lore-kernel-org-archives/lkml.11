Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EE56C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Mar 2022 14:46:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238078AbiC2Osc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Mar 2022 10:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238188AbiC2OsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 10:48:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5C665577D;
        Tue, 29 Mar 2022 07:46:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CCFC5B8181A;
        Tue, 29 Mar 2022 14:46:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD6D9C2BBE4;
        Tue, 29 Mar 2022 14:46:29 +0000 (UTC)
Date:   Tue, 29 Mar 2022 10:46:27 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     cgel.zte@gmail.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Lv Ruyi <lv.ruyi@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] proc: bootconfig: add null pointer check
Message-ID: <20220329104627.3570daea@gandalf.local.home>
In-Reply-To: <20220329233053.bf162ee2e15f742ac967213a@kernel.org>
References: <20220329104004.2376879-1-lv.ruyi@zte.com.cn>
        <20220329233053.bf162ee2e15f742ac967213a@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Mar 2022 23:30:53 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Hi Steve,
> 
> Can you pick this with below lines? This seems to be there from v5.6.
> 
> Fixes: c1a3c36017d4 ("proc: bootconfig: Add /proc/bootconfig to show boot config list")
> Cc: stable@vger.kernel.org
> Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
> 
> 

Sure.

-- Steve
