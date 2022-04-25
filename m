Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36168C433FE
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Apr 2022 14:53:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239996AbiDYO4D convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Apr 2022 10:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbiDYO4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 10:56:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD00133E1E;
        Mon, 25 Apr 2022 07:52:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 04E57B8185F;
        Mon, 25 Apr 2022 14:52:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD35CC385A4;
        Mon, 25 Apr 2022 14:52:52 +0000 (UTC)
Date:   Mon, 25 Apr 2022 10:52:51 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Tony Luck <tony.luck@intel.com>
Cc:     hdegoede@redhat.com, markgross@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, corbet@lwn.net,
        gregkh@linuxfoundation.org, andriy.shevchenko@linux.intel.com,
        jithu.joseph@intel.com, ashok.raj@intel.com,
        dan.j.williams@intel.com, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        patches@lists.linux.dev, ravi.v.shankar@intel.com
Subject: Re: [PATCH v4 09/10] trace: platform/x86/intel/ifs: Add trace point
 to track Intel IFS operations
Message-ID: <20220425105251.3f5e8021@gandalf.local.home>
In-Reply-To: <20220422200219.2843823-10-tony.luck@intel.com>
References: <20220419163859.2228874-1-tony.luck@intel.com>
        <20220422200219.2843823-1-tony.luck@intel.com>
        <20220422200219.2843823-10-tony.luck@intel.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Apr 2022 13:02:18 -0700
Tony Luck <tony.luck@intel.com> wrote:

> Add tracing support which may be useful for debugging systems that fail to complete
> In Field Scan tests.
> 
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> ---
>  MAINTAINERS                              |  1 +
>  drivers/platform/x86/intel/ifs/runtest.c |  5 ++++
>  include/trace/events/intel_ifs.h         | 38 ++++++++++++++++++++++++

From the tracing POV:

Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve
