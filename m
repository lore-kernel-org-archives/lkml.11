Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3411FC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Mar 2022 09:14:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356567AbiCYJQ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Mar 2022 05:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352556AbiCYJQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 05:16:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B3A2ACF49D
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 02:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648199687;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
        b=DnhnVguWadoOLwkp6LaxL7wkQTorxgIZz30KW25LZl+HFTFSL4N+7gE5oyxuTXwy16Dq1S
        Wp7IgEpxNUz2uCB0+GRFGoKyvqNdVFz+vrAn6//6/0RIkeoioKDCfqoFWAQqdV+3AUhUFJ
        AVjJ3OwIAbtLIOn32LTlJrtu9C91Or0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-390-3Z8SjD8ZN_uDCGA54dtYlQ-1; Fri, 25 Mar 2022 05:14:45 -0400
X-MC-Unique: 3Z8SjD8ZN_uDCGA54dtYlQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 317F93C153D3;
        Fri, 25 Mar 2022 09:14:43 +0000 (UTC)
Received: from avogadro.redhat.com (unknown [10.39.195.65])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4915214583C1;
        Fri, 25 Mar 2022 09:14:41 +0000 (UTC)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     Zhenzhong Duan <zhenzhong.duan@intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        pbonzini@redhat.com, seanjc@google.com, vkuznets@redhat.com,
        wanpengli@tencent.com, jmattson@google.com, joro@8bytes.org
Subject: Re: [PATCH v2 0/2] minor cleanups on efer emulation
Date:   Fri, 25 Mar 2022 10:14:39 +0100
Message-Id: <20220325091439.289953-1-pbonzini@redhat.com>
In-Reply-To: <20220311102643.807507-1-zhenzhong.duan@intel.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Queued, thanks.

Paolo


