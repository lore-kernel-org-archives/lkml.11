Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBBE7C3F6B0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Aug 2022 10:00:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236463AbiHBKAv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Aug 2022 06:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232695AbiHBKAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 06:00:47 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C87915831;
        Tue,  2 Aug 2022 03:00:46 -0700 (PDT)
Date:   Tue, 2 Aug 2022 12:00:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1659434444;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fWS91HOnYcPg5dE0ildC+1U0SbgjO3xl/PLhDrRtUL0=;
        b=pLJ0h3AjWnl+yyymFFN6YKAJ2Dx/jHk0ws0sn9sVVa6oKeylP+7YRbsCbxBjkaZi8njWdf
        g0mvbIaY17MlpWKTDPKjS8rz1WPsFzWU3xB4RlVmY4mB/uezw0ZBglbV7tOZJQtnIVdTYA
        WkqWhYAo8EdGGqYawoJcGY0D9QrJcWw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Andrew Jones <andrew.jones@linux.dev>
To:     Peter Gonda <pgonda@google.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        marcorr@google.com, seanjc@google.com, michael.roth@amd.com,
        thomas.lendacky@amd.com, joro@8bytes.org, mizhang@google.com,
        pbonzini@redhat.com
Subject: Re: [V2 02/11] KVM: selftests: sparsebit: add const where appropriate
Message-ID: <20220802100044.p5kxjzz6avxrkzyh@kamzik>
References: <20220801201109.825284-1-pgonda@google.com>
 <20220801201109.825284-3-pgonda@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220801201109.825284-3-pgonda@google.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 01, 2022 at 01:11:00PM -0700, Peter Gonda wrote:
> From: Michael Roth <michael.roth@amd.com>
> 
> Subsequent patches will introduce an encryption bitmap in kvm_util that
> would be useful to allow tests to access in read-only fashion. This
> will be done via a const sparsebit*. To avoid warnings or the need to
> add casts everywhere, add const to the various sparsebit functions that
> are applicable for read-only usage of sparsebit.
> 
> Signed-off-by: Michael Roth <michael.roth@amd.com>
> Signed-off-by: Peter Gonda <pgonda@google.com>
> ---
>  .../testing/selftests/kvm/include/sparsebit.h | 36 +++++++-------
>  tools/testing/selftests/kvm/lib/sparsebit.c   | 48 +++++++++----------
>  2 files changed, 42 insertions(+), 42 deletions(-)
>

Reviewed-by: Andrew Jones <andrew.jones@linux.dev>
