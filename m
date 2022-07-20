Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59B16C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jul 2022 18:04:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232561AbiGTSEF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jul 2022 14:04:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbiGTSEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 14:04:01 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3CAE5C36B
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 11:03:59 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id x24-20020a17090ab01800b001f21556cf48so2808325pjq.4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 11:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wPgDlsIjSt7ILiihh1+1WsRwcr42caYDplzbQCF0rgE=;
        b=IjNXIRL/qkgJ7y9brcpaV0DL2vOv7xEwYYRX/524Il5GaA8rOGvwlKpaprpQpZlHiD
         80YPJldEZmGIQrHMhcxclb8EWCC808UifrGFY7nmsQ/Y2h9+yl63gU3DfckOf2Ij81hY
         ODN8KRsfagfQcOBm+PSn46bZRCP08+ON0QmUwy0/5w3JD64mTWNAOWdvLMHcfXdRP5Cb
         IeKZO06dhtbGc3J8pWYl0E3IYuALQrqZ2PNtuZrfabfbYKeQZhu09jz/ALba5DKP6748
         elh40lesNCnggiGowhwl9aX4839O6JqCgZzQYVMraYSlMJSGoOl2VyN3xQMaGUpsqgZV
         RH1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=wPgDlsIjSt7ILiihh1+1WsRwcr42caYDplzbQCF0rgE=;
        b=gBfP0NPmFpbS8tSF4UqBSV8hNHabFPNHCVYmkw8sedpZstz6sxipkA0MH7eA7PDf7N
         CYNVSQFCnBfK1u7qcam1ipOxWfeisb5ShLwN2fik9DcDd0w/q1kMIfZ5fqHbX+ZVD+nw
         MA/1KTHmwEfZupDhJwELSHjZZGmKmBy6In/1c+zglkAkZpGZxHDBOum1CFcQdoG7FEF5
         tJLYtayK8hqWTY9OaDj8K1UVsm0GFhra/H9g3nRtK8y33EronOOD1fawpbG8tjCWf4LL
         y0ngWI7bZZfqoa9n9eWmdsy1FjyW12UJ7TXxrbWEkpl9GpLP4RWijhm7N9BXWHhpB9og
         v7wA==
X-Gm-Message-State: AJIora9ebNNbtWdix57xuQJlxQK+qnHpOzdlckWnHwr2nn8E4BooifnJ
        tI4dl2Xs10IXRquVc1YYqV4=
X-Google-Smtp-Source: AGRyM1sLRjhnuqKI1RFALr1ui2VUMIF5f9K9B6eAOSsh9vnMBLzZF+fkYTFgvHL4gKncEEMi4xDl8Q==
X-Received: by 2002:a17:903:2644:b0:16d:1f61:399e with SMTP id je4-20020a170903264400b0016d1f61399emr4783584plb.38.1658340239063;
        Wed, 20 Jul 2022 11:03:59 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:f3dd])
        by smtp.gmail.com with ESMTPSA id z1-20020a170903018100b0016bd8fb1fafsm14388024plg.307.2022.07.20.11.03.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 11:03:58 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 20 Jul 2022 08:03:56 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Valentin Schneider <vschneid@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Phil Auld <pauld@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [RFC PATCH] workqueue: Unbind workers before sending them to
 exit()
Message-ID: <YthDjPq3CtWc+o0/@slm.duckdns.org>
References: <20220719165743.3409313-1-vschneid@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220719165743.3409313-1-vschneid@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 19, 2022 at 05:57:43PM +0100, Valentin Schneider wrote:
> It has been reported that isolated CPUs can suffer from interference due to
> per-CPU kworkers waking up just to die.
> 
> A surge of workqueue activity (sleeping workfn's exacerbate this) during
> initial setup can cause extra per-CPU kworkers to be spawned. Then, a
> latency-sensitive task can be running merrily on an isolated CPU only to be
> interrupted sometime later by a kworker marked for death (cf.
> IDLE_WORKER_TIMEOUT, 5 minutes after last kworker activity).
> 
> Affine kworkers to the wq_unbound_cpumask (which doesn't contain isolated
> CPUs, cf. HK_TYPE_WQ) before waking them up after marking them with
> WORKER_DIE.
> 
> This follows the logic of CPU hot-unplug, which has been packaged into
> helpers for the occasion.

Idea-wise, seems fine to me, but we have some other issues around twiddling
cpu affinities right now, so let's wait a bit till Lai chimes in.

Thanks.

-- 
tejun
