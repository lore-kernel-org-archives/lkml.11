Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F9DBC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Mar 2022 01:19:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239137AbiCJBUU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Mar 2022 20:20:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232099AbiCJBUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 20:20:15 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D686364BC4
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 17:19:15 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id n2so3504738plf.4
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 17:19:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n+UZjpsoxN6IYCQw8x6bxVwfEl6GkVr8xzwzIYJYyGw=;
        b=BPGGCkWbzIcKLTDl+gRoyAuhvVHWYWsLqhI02EDVZPViCTYfhp/FBFAbEKf8UgVMYF
         KA3iT2+CkOydgm8JDds2x5PiDaHFI/K7N+sTrtGNV6WboKDBMS1RDeyVbwKoWU/90NiY
         xTeFf7Gh7qkZEfbjmC+AAGEGN3/xEXaSnGMhxaUwGlh/2V3lVVAUX4z2phxLkKJve9kF
         iGpFcOcMj3hfEYtcyDSkUExTuyJClUa0DCZXqW5+0LHXb4bOxzwF0r/2kJn1qIpHDYfh
         2TStDdSMaLfpVOXbUlebkY3kMPT1d7VdnY50j11tCDkkYlHHTVZ5kuBFgnSeXjUxEAp5
         h86Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n+UZjpsoxN6IYCQw8x6bxVwfEl6GkVr8xzwzIYJYyGw=;
        b=VCNlKc3FzkJzjfgn9eMoHV29rBTsiaOG49MP9dZMahuDpzQlQhCpMC27KdZHHz9p9D
         8OqN2LKG+kZ6mEs1VN9m8CQhQdcQ5FLmeytL09ji1ngPZglGtvbYZZcF9xl6q7xa9TaV
         LH13hs1AJ85J4NALbsQE5CGEYXmFofRmtqGrwyaRBqhOIrCYzwo45M1AjOiNi/xp5SsN
         Ww9FG9ujI2NwQNestkrDUMngxq6McDjFy7zT4NdruXw3OPab2Mbet36bThoQQOMy+G/+
         xVtvfkKPqn36KkDOrqnCLx98B1F5k4JJkezTM/N0yHNeQRBegRj2Udw36ZjLGUDmjdBl
         DnSQ==
X-Gm-Message-State: AOAM5317Gi14ESh+7WzGE8aQ/p7KIx+bNVE/tM1UBxzEEJ25O+h7/Ytu
        qUrxvHct7CAkwfqcjQieID1IPkPYgD7G8nz6yww=
X-Google-Smtp-Source: ABdhPJwoQxnFaBLEmUeYVQygU3HFf1EidW8oPfr/0UgAGgLQr/jySJheNd/cTw1dTFR8IqrM/SoPk6NySnSIPCk4pgw=
X-Received: by 2002:a17:903:11c4:b0:151:9bf6:f481 with SMTP id
 q4-20020a17090311c400b001519bf6f481mr2588996plh.50.1646875155466; Wed, 09 Mar
 2022 17:19:15 -0800 (PST)
MIME-Version: 1.0
References: <20220309145052.219138-1-sxwjean@me.com> <20220309145052.219138-2-sxwjean@me.com>
 <6b5858d7-2d19-a57e-b840-9616e3f5d892@google.com>
In-Reply-To: <6b5858d7-2d19-a57e-b840-9616e3f5d892@google.com>
From:   Xiongwei Song <sxwjean@gmail.com>
Date:   Thu, 10 Mar 2022 09:18:49 +0800
Message-ID: <CAEVVKH_m7HzaFAQ-ape3i2W2Ji1rCjiSqUjoXrQvYCTHkn1JXA@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm: slab: Delete unused SLAB_DEACTIVATED flag
To:     David Rientjes <rientjes@google.com>
Cc:     Xiongwei Song <sxwjean@me.com>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, longman@redhat.com,
        guro@fb.com, linux-mm@kvack.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 10, 2022 at 1:14 AM David Rientjes <rientjes@google.com> wrote:
>
> On Wed, 9 Mar 2022, sxwjean@me.com wrote:
>
> > From: Xiongwei Song <sxwjean@gmail.com>
> >
> > Since commit 9855609bde03 ("mm: memcg/slab: use a single set of
> > kmem_caches for all accounted allocations") deletes all SLAB_DEACTIVATED
> > users, therefore this flag is not needed any more, let's delete it.
> >
> > Signed-off-by: Xiongwei Song <sxwjean@gmail.com>
>
> Acked-by: David Rientjes <rientjes@google.com>

Thank you!
