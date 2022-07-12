Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C211C43334
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jul 2022 01:00:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232067AbiGLBAJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jul 2022 21:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiGLBAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 21:00:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43880286C9
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 18:00:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D148761515
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 01:00:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69516C34115;
        Tue, 12 Jul 2022 01:00:02 +0000 (UTC)
Date:   Mon, 11 Jul 2022 21:00:00 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     sunliming <sunliming@kylinos.cn>, ast@kernel.org, jolsa@kernel.org,
        linux-kernel@vger.kernel.org, kelulanainsley@gmail.com,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] fprobe/samples: make sample_probe static
Message-ID: <20220711210000.72f33dad@gandalf.local.home>
In-Reply-To: <20220606234310.b0f893ee35c0106e414bd67f@kernel.org>
References: <20220606075659.674556-1-sunliming@kylinos.cn>
        <20220606234310.b0f893ee35c0106e414bd67f@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Jun 2022 23:43:10 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> Looks good to me. Thanks for the fix!
> 
> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Applied, thanks sunliming and Masami!

-- Steve
